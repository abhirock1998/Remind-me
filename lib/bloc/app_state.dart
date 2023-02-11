part of 'app_bloc.dart';

// get issue status
enum GetMyIssueStatus { loading, failed, success, initial }

extension GetMyIssueStatusX on GetMyIssueStatus {
  bool get isInitial => this == GetMyIssueStatus.initial;
  bool get isSuccess => this == GetMyIssueStatus.success;
  bool get isError => this == GetMyIssueStatus.failed;
  bool get isLoading => this == GetMyIssueStatus.loading;
}

GetMyIssueStatus getMyIssuesStatus(String value) {
  for (var e in GetMyIssueStatus.values) {
    if (e.toString() == value) return e;
  }
  return GetMyIssueStatus.initial;
}

// logged in status
enum LoggedInStatus { loading, failed, success, initial }

extension LoggedInStatusX on LoggedInStatus {
  bool get isInitial => this == LoggedInStatus.initial;
  bool get isSuccess => this == LoggedInStatus.success;
  bool get isError => this == LoggedInStatus.failed;
  bool get isLoading => this == LoggedInStatus.loading;
}

LoggedInStatus getLoggedInStatus(String value) {
  for (var e in LoggedInStatus.values) {
    if (e.toString() == value) return e;
  }
  return LoggedInStatus.initial;
}

//  Time log

enum TimeLogStatus { loading, failed, success, initial }

extension TimeLogStatusX on TimeLogStatus {
  bool get isInitial => this == TimeLogStatus.initial;
  bool get isSuccess => this == TimeLogStatus.success;
  bool get isError => this == TimeLogStatus.failed;
  bool get isLoading => this == TimeLogStatus.loading;
}

class AppState extends Equatable {
  final GetMyIssueStatus myIssueStatus;
  final RedmineUser redmineUser;
  final bool isLoggedIn;
  final LoggedInStatus loggedInStatus;
  final List<RedmineIssues> issues;
  final int selectedIssuesId;
  final TimeLogStatus timeLogStatus;
  final int todayLoggedHours;
  final int todayLoggedHoursGoal;
  const AppState({
    this.myIssueStatus = GetMyIssueStatus.initial,
    required this.redmineUser,
    this.isLoggedIn = false,
    this.loggedInStatus = LoggedInStatus.initial,
    this.issues = const [],
    this.selectedIssuesId = -1,
    this.timeLogStatus = TimeLogStatus.initial,
    this.todayLoggedHours = 0,
    this.todayLoggedHoursGoal = 5 * 60 * 60,
  });

  @override
  List<Object> get props => [
        myIssueStatus,
        redmineUser,
        isLoggedIn,
        loggedInStatus,
        issues,
        selectedIssuesId,
        timeLogStatus,
        todayLoggedHours,
        todayLoggedHoursGoal,
      ];

  AppState copyWith({
    GetMyIssueStatus? myIssueStatus,
    RedmineUser? redmineUser,
    bool? isLoggedIn,
    LoggedInStatus? loggedInStatus,
    List<RedmineIssues>? issues,
    int? selectedIssuesId,
    TimeLogStatus? timeLogStatus,
    int? todayLoggedHours,
    int? todayLoggedHoursGoal,
  }) {
    return AppState(
      myIssueStatus: myIssueStatus ?? this.myIssueStatus,
      redmineUser: redmineUser ?? this.redmineUser,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      loggedInStatus: loggedInStatus ?? this.loggedInStatus,
      issues: issues ?? this.issues,
      selectedIssuesId: selectedIssuesId ?? this.selectedIssuesId,
      timeLogStatus: timeLogStatus ?? this.timeLogStatus,
      todayLoggedHours: todayLoggedHours ?? this.todayLoggedHours,
      todayLoggedHoursGoal: todayLoggedHoursGoal ?? this.todayLoggedHoursGoal,
    );
  }

  factory AppState.fromJson(Map<String, dynamic> jsonData) {
    RedmineUser parseUser;
    List<RedmineIssues> parseIssuess = <RedmineIssues>[];

    if (jsonData['redmineUser'] != null) {
      parseUser = RedmineUser.fromJson(jsonData['redmineUser']);
    } else {
      parseUser = RedmineUser();
    }

    if (jsonData['issues'] != null) {
      jsonData["issues"].forEach((v) {
        parseIssuess.add(RedmineIssues.fromJson(v));
      });
    } else {
      parseIssuess = [];
    }

    return AppState(
      myIssueStatus: getMyIssuesStatus(jsonData['myIssueStatus']),
      redmineUser: parseUser,
      isLoggedIn: json.decode(jsonData['isLoggedIn']) as bool,
      loggedInStatus: getLoggedInStatus(jsonData['loggedInStatus']),
      issues: parseIssuess,
      selectedIssuesId: json.decode(jsonData["selectedIssuesId"]) as int,
      timeLogStatus: TimeLogStatus.initial,
      todayLoggedHours: json.decode(jsonData['todayLoggedHours']) as int,
      todayLoggedHoursGoal:
          json.decode(jsonData['todayLoggedHoursGoal']) as int,
    );
  }

  Map<String, dynamic> toJson(AppState state) {
    return <String, dynamic>{
      "myIssueStatus": state.myIssueStatus.toString(),
      "redmineUser": state.redmineUser.toJson(),
      "isLoggedIn": state.isLoggedIn.toString(),
      "loggedInStatus": state.loggedInStatus.toString(),
      "issues": state.issues.map((e) => e.toJson()).toList(),
      "selectedIssuesId": state.selectedIssuesId.toString(),
      "timeLogStatus": state.timeLogStatus.toString(),
      "todayLoggedHours": state.todayLoggedHours.toString(),
      "todayLoggedHoursGoal": state.todayLoggedHoursGoal.toString(),
    };
  }
}
