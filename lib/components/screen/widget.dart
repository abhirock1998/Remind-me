import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    super.key,
    this.bottom = 20,
    this.left = 20,
    this.right = 20,
    this.top = 20,
    required this.child,
  });
  final double top, bottom, left, right;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: bottom, left: left, right: right, top: top),
      child: child,
    );
  }
}
