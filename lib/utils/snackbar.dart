import 'package:flutter/material.dart';
import 'package:notify/utils/colors.dart';

class SnackBarManager {
  static TextStyle style = const TextStyle(color: Colors.white, fontSize: 14);
  static showErrorSnackBar(BuildContext context, String title) {
    final snackBar = SnackBar(
      content: Text(title, style: style),
      duration: const Duration(milliseconds: 500),
      backgroundColor: AppColor.erroBorder,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showSnackSuccess(BuildContext context, String title) {
    final snackBar = SnackBar(
      content: Text(title, style: style),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColor.greenColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showSnackAlert(BuildContext context, String title) {
    final snackBar = SnackBar(
      content: Text(title, style: style),
      duration: const Duration(milliseconds: 500),
      backgroundColor: AppColor.blueColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
