import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notify/features/features.dart';
import 'package:notify/utils/colors.dart';

class DebugButton extends StatelessWidget {
  const DebugButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(Debugger());
      },
      child: Text(
        "Debug",
        style: TextStyle(
          color: AppColor.greenColor,
        ),
      ),
    );
  }
}
