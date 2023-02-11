import 'package:flutter/material.dart';
import 'package:notify/utils/colors.dart';
import 'package:notify/utils/layout.dart';

Future<void> onDoneDialog(
    BuildContext context, Widget child, GestureTapCallback onSubmit) async {
  return showDialog<void>(
    context: context,

    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Time Log",
          style: TextStyle(
            color: AppColor.white,
          ),
        ),
        backgroundColor: AppColor.bgColor,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Can you tell me what you have done in the last half hour?',
                style: TextStyle(fontSize: 16, color: AppColor.inputHintColor),
              ),
              SizedBox(height: AppLayout.getHeight(context, 20)),
              child
            ],
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: onSubmit,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Submit',
                style: TextStyle(color: AppColor.greenColor),
              ),
            ),
          ),
        ],
      );
    },
  );
}
