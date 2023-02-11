// ignore_for_file: avoid_print

import 'package:ansicolor/ansicolor.dart';

// /// [LogService] is a utility to print messages to the console
// /// with configuration for different colors
class LogService {
  static List<Map<String, String>> logs = [];
  static final AnsiPen _penError = AnsiPen()..red(bold: true);
  static final AnsiPen _penSuccess = AnsiPen()..green(bold: true);
  static final AnsiPen _penInfo = AnsiPen()..yellow(bold: true);

  static void error(String msg) {
    const sep = '\n';
    msg = _penError('✖ ${msg.trim()}');
    msg = msg + sep;
    final data = <String, String>{};
    data["type"] = "error";
    data["msg"] = msg;
    logs.add(data);
    print(msg);
  }

  static void success(dynamic msg) {
    final data = <String, String>{};
    data["type"] = "success";
    data["msg"] = msg;
    logs.add(data);
    print(_penSuccess('✓ $msg'));
  }

  static void info(
    String msg, {
    bool trim = false,
    bool newLines = true,
  }) {
    final sep = newLines ? '\n' : '';
    if (trim) msg = msg.trim();
    msg = _penInfo(msg);

    msg = sep + msg.toString() + sep;
    final data = <String, String>{};
    data["type"] = "info";
    data["msg"] = msg;
    logs.add(data);
    print(msg);
  }
}
