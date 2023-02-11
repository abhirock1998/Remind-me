import 'package:flutter/material.dart';
import 'package:notify/utils/colors.dart';
import 'package:notify/utils/layout.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onTap,
    required this.isTapped,
  });
  final bool isTapped;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppLayout.getWidth(context, 180),
        height: AppLayout.getHeight(context, 45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColor.btnBg,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                spreadRadius: 0,
                blurRadius: 2,
                blurStyle: BlurStyle.outer,
              )
            ]),
        child: !isTapped
            ? const Text(
                'Log In',
                style: TextStyle(color: Colors.white, fontSize: 17),
              )
            : SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColor.white,
                  strokeWidth: 1,
                ),
              ),
      ),
    );
  }
}
