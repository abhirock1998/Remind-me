import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/bloc/app_bloc.dart';
import 'package:notify/components/components.dart';
import 'package:notify/features/features.dart';
import 'package:notify/features/home/screen.dart';
import 'package:notify/utils/colors.dart';
import 'package:notify/utils/layout.dart';
import 'package:notify/utils/logger.dart';
import 'package:notify/utils/snackbar.dart';

class Login extends StatefulWidget {
  static String screenId = 'login_screen';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [DebugButton()],
      ),
      body: SafeArea(
        child: ScreenWrapper(
          child: BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {
              if (state.loggedInStatus.isSuccess && isPressed) {
                LogService.success('Successfully logged in');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const Home();
                    },
                  ),
                );
              }
              if (state.loggedInStatus.isError) {
                SnackBarManager.showErrorSnackBar(context, "You fucked up");
                setState(() {
                  isPressed = false;
                });
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Column(
                    children: [
                      LogInputFormField(
                        controller: _email,
                        hintText: 'Enter username *',
                      ),
                      SizedBox(height: AppLayout.getHeight(context, 20)),
                      LogInputFormField(
                        controller: _password,
                        hintText: 'Enter password *',
                        isPassword: true,
                      ),
                      SizedBox(height: AppLayout.getHeight(context, 20)),
                      SubmitButton(
                        isTapped: isPressed,
                        onTap: () {
                          if (_email.text.isEmpty) {
                            SnackBarManager.showErrorSnackBar(
                                context, "Enter valid username");
                            return;
                          }
                          LogService.info("Valid username entered");
                          if (_password.text.isEmpty) {
                            SnackBarManager.showErrorSnackBar(
                                context, "Enter valid password");
                            return;
                          }
                          LogService.info("Valid password entered");
                          LogService.info("Ready to login");
                          setState(() {
                            isPressed = true;
                          });
                          LogService.info("Call login functionality in Bloc");
                          context
                              .read<AppBloc>()
                              .getUserVerify(_email.text, _password.text);
                        },
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LogInputFormField extends StatelessWidget {
  const LogInputFormField({
    super.key,
    required this.controller,
    this.validator,
    this.isPassword = false,
    this.hintText = '',
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.inputFieldBg,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer,
            ),
          ]),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: AppColor.white,
        ),
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: AppColor.inputHintColor,
            fontSize: 15,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          // enabledBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.white60,
          //   ),
          // ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.inputActiveBorder,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.erroBorder,
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.white,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
