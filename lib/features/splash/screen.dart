import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notify/bloc/app_bloc.dart';
import 'package:notify/features/home/screen.dart';
import 'package:notify/features/login/screen.dart';
import 'package:notify/utils/colors.dart';
import 'package:notify/utils/layout.dart';

class Splash extends StatelessWidget {
  static String screenId = 'splash_screen';
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'app-logo',
                  child: Image.asset(
                    'assets/icon/stopwatch.png',
                    height: AppLayout.getHeight(context, 100),
                  ),
                ),
              ),
              SizedBox(height: AppLayout.getHeight(context, 20)),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'Canterbury',
                  color: AppColor.white,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  onFinished: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return state.isLoggedIn
                              ? const Home()
                              : const Login();
                        },
                      ),
                    );
                  },
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Remind Me',
                      speed: const Duration(milliseconds: 500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
