import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notify/models/redmine_issue.dart';
import 'package:notify/models/redmine_time_log.dart';
import 'package:notify/models/redmine_user.dart';

class RedmineService {
  static String baseUrl = "https://kore.koders.in";
  final _storage = const FlutterSecureStorage();

  Uri getUri(String endPoint) => Uri.parse('$baseUrl/$endPoint');

  /// Helper function for creating Headers
  Future<Map<String, String>> makeHeader({
    Map<String, String>? extraParameters,
    bool isJson = true,
  }) async {
    final token = await getAndSaveAccessToken(isGet: true);
    final queryParameters = <String, String>{'X-Redmine-API-Key': '$token'};
    if (isJson) {
      queryParameters.addAll({'Content-Type': 'application/json'});
    }
    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return queryParameters;
  }

  /// Persist Access token for future API call
  Future<String?> getAndSaveAccessToken(
      {bool isGet = false, String? tkn}) async {
    if (isGet) {
      return await _storage.read(key: "REDMINE_TOKEN");
    } else {
      await _storage.write(key: "REDMINE_TOKEN", value: tkn);
      return null;
    }
  }

  Future<MyIssues> getMyIssues() async {
    try {
      String url = '/issues.json?assigned_to_id=me';
      final response = await http.get(getUri(url), headers: await makeHeader());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MyIssues.fromJson(data);
      }
      throw Exception(response.reasonPhrase);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RedmineUser> verifyUser(String email, String password) async {
    try {
      String url = '/my/account.json';
      final headers = <String, String>{};
      final string = '$email:$password';
      String bs64 = base64.encode(string.codeUnits);
      headers['authorization'] = "Basic $bs64";
      final response = await http.get(getUri(url), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = RedmineUser.fromJson(data);
        await getAndSaveAccessToken(tkn: user.user?.apiKey);
        return RedmineUser.fromJson(data);
      }
      throw Exception(response.reasonPhrase);
    } catch (e) {
      throw Exception(e);
    }
  }

  //https://www.redmine.org/projects/redmine/wiki/Rest_TimeEntries
  Future<bool> autoTimeLogger(TimeEntry timeEntry) async {
    try {
      final body = {
        "time_entry": timeEntry.toJson(),
      };
      String url = '/time_entries.json';
      final response = await http.post(getUri(url),
          body: json.encode(body), headers: await makeHeader());
      if (response.statusCode == 201) {
        return true;
      }
      throw Exception(response.reasonPhrase);
    } catch (e) {
      throw Exception(e);
    }
  }
}
