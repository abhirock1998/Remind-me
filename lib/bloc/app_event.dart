part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class GetUserVerify extends AppEvent {
  final String email;
  final String pass;
  const GetUserVerify({required this.email, required this.pass});

  @override
  List<Object> get props => [email, pass];
}

class GetMyIssues extends AppEvent {
  final bool? isManual;
  const GetMyIssues({this.isManual});

  @override
  List<Object> get props => [];
}

class SetIssueId extends AppEvent {
  final int id;
  const SetIssueId({required this.id});
  @override
  List<Object> get props => [id];
}

class TimeEntryLog extends AppEvent {
  final TimeEntry entry;
  const TimeEntryLog({required this.entry});
  @override
  List<Object> get props => [entry];
}
