import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/bloc/app_bloc.dart';
import 'package:notify/utils/colors.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final user = state.redmineUser;
        final currentHrs = state.todayLoggedHours;
        final totalHrs = state.todayLoggedHoursGoal;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: RichText(
                text: TextSpan(
                  text: "Hi, ",
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: "${user.user?.firstname}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: LinearProgressIndicator(
                  semanticsLabel: "Logged time",
                  value: currentHrs / totalHrs,
                  minHeight: 10,
                  semanticsValue: 'Logged time',
                  backgroundColor: AppColor.btnBg,
                  color: AppColor.greenColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
