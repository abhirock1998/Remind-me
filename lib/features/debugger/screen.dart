import 'package:flutter/material.dart';
import 'package:notify/utils/colors.dart';
import 'package:notify/utils/logger.dart';

class Debugger extends ModalRoute<void> {
  static String screenId = 'debugger';
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,

      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      color: AppColor.bgColor.withOpacity(0.6),
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                "Close",
                style: TextStyle(color: AppColor.white, fontSize: 16),
              ),
            ),
          ),
          ...LogService.logs.map((e) {
            final type = e["type"] ?? "info";
            final color = type == "success"
                ? AppColor.greenColor
                : type == "error"
                    ? AppColor.erroBorder
                    : AppColor.white;
            return Text(
              "[$type] - ${e["msg"]}",
              style: TextStyle(color: color, fontSize: 12),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
