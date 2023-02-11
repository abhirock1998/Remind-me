import 'package:notify/models/redmine_issue.dart';
import 'package:notify/models/redmine_time_log.dart';
import 'package:notify/models/redmine_user.dart';

import './services/redmine.dart';

class AppRepository {
  const AppRepository({
    required this.service,
  });
  final RedmineService service;

  Future<MyIssues> getMyIssues(String mobile) async => service.getMyIssues();
  Future<RedmineUser> verifyUser(String email, String password) async =>
      service.verifyUser(email, password);
  Future<bool> autoTimeLogger(TimeEntry timeEntry) async =>
      service.autoTimeLogger(timeEntry);
}
