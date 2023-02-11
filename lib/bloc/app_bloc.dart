import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notify/models/redmine_issue.dart';
import 'package:notify/models/redmine_time_log.dart';
import 'package:notify/models/redmine_user.dart';
import 'package:notify/repository/repository.dart';
import 'package:notify/utils/crypto.dart';
import 'package:notify/utils/logger.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  final AppRepository repository;

  void onGetMyIssue(bool? isManual) {
    add(GetMyIssues(isManual: isManual));
  }

  void getUserVerify(String email, String password) {
    add(GetUserVerify(email: email, pass: password));
  }

  void onIssueSelected(int id) {
    add(SetIssueId(id: id));
  }

  void onTimeLog(TimeEntry entry) {
    add(TimeEntryLog(entry: entry));
  }

  AppBloc({required this.repository})
      : super(AppState(
          redmineUser: RedmineUser(),
        )) {
    on<AppEvent>((event, emit) async {
      if (event is GetMyIssues) {
        try {
          if (event.isManual == false) {
            if (state.issues.isNotEmpty) {
              LogService.info('Already fetch lastes issue dont fetch');
              return;
            }
          }
          emit(state.copyWith(myIssueStatus: GetMyIssueStatus.loading));
          final response = await repository.service.getMyIssues();
          LogService.success('Successfully fetch new issues from Redmine');
          emit(state.copyWith(
            issues: response.issues,
            myIssueStatus: GetMyIssueStatus.success,
          ));
        } catch (e) {
          LogService.error('Error during getting my issues $e');
          emit(state.copyWith(myIssueStatus: GetMyIssueStatus.failed));
        }
      } else if (event is GetUserVerify) {
        try {
          emit(state.copyWith(loggedInStatus: LoggedInStatus.loading));
          final email = event.email;
          final pass = event.pass;
          LogService.info('Verifying user with $email');
          final response = await repository.service.verifyUser(email, pass);
          response.user?.avatar =
              createGravatarURL(response.user?.mail ?? "polo@gmail.com");
          LogService.success('Successfully verified user');
          emit(state.copyWith(
            redmineUser: response,
            isLoggedIn: true,
            loggedInStatus: LoggedInStatus.success,
          ));
        } catch (e) {
          emit(state.copyWith(
              redmineUser: null,
              isLoggedIn: false,
              loggedInStatus: LoggedInStatus.failed));
          LogService.error('Error during User verification: $e');
        }
      } else if (event is SetIssueId) {
        emit(state.copyWith(selectedIssuesId: event.id));
      } else if (event is TimeEntryLog) {
        try {
          LogService.info('Trying to add time entry into Redmine');
          emit(state.copyWith(timeLogStatus: TimeLogStatus.loading));
          await repository.service.autoTimeLogger(event.entry);
          final successMsg = 'Successfully time log ${event.entry.issueId}';
          LogService.success(successMsg);
          final preHrs = state.todayLoggedHours;
          emit(state.copyWith(
              timeLogStatus: TimeLogStatus.success,
              todayLoggedHours: preHrs + 30 * 60));
        } catch (e) {
          LogService.error('Error during time log $e');
          emit(state.copyWith(timeLogStatus: TimeLogStatus.failed));
        }
      }
    });
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return state.toJson(state);
  }
}
