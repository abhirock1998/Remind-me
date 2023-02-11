import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/components/components.dart';

import 'package:notify/bloc/app_bloc.dart';
import 'package:notify/features/home/widget/prompt.dart';
import 'package:notify/models/redmine_time_log.dart';
import 'package:notify/utils/colors.dart';
import 'package:notify/utils/layout.dart';
import 'package:notify/utils/snackbar.dart';

class MyPomodoro extends StatefulWidget {
  const MyPomodoro({super.key});

  @override
  State<MyPomodoro> createState() => _MyPomodoroState();
}

class _MyPomodoroState extends State<MyPomodoro> {
  final CountdownNumberController _controller =
      CountdownNumberController(autoStart: false);
  TextEditingController controller = TextEditingController();
  bool isStarted = false;
  bool isSubmitted = false;

  AudioPlayer player = AudioPlayer();

  void play() async {
    await player.play(AssetSource('audio/timer.mp3'));
  }

  void playInLoop() {
    play();
    player.onPlayerComplete.listen((event) {
      play();
      player.setVolume(10);
    });
  }

  void exitLoop() {
    player.stop();
  }

  void handleDoneCallback(int? issueId) async {
    playInLoop();
    onDoneDialog(context, PomodoroInputField(controller: controller), () {
      if (controller.text.isEmpty) {
        SnackBarManager.showErrorSnackBar(context, 'Enter description');
        return;
      }
      setState(() {
        isSubmitted = true;
        isStarted = false;
      });
      final entry = TimeEntry(
          issueId: issueId,
          hours: "0:30",
          userId: 17,
          comments: controller.text);

      context.read<AppBloc>().onTimeLog(entry);
      exitLoop();
      controller.clear();
      _controller.reset();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.timeLogStatus.isSuccess && isSubmitted) {
          SnackBarManager.showSnackSuccess(context, 'Time Successfully logged');
        }
        if (state.loggedInStatus.isError) {
          setState(() {
            isSubmitted = false;
          });
        }
      },
      builder: (context, state) {
        final selectedId = state.selectedIssuesId;
        if (selectedId > 0) {
          if (state.issues.isEmpty) return const SizedBox();
          final issue = state.issues[selectedId];
          return Container(
            height: AppLayout.getHeight(context, 200),
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Timer: \t",
                        style: TextStyle(
                            fontSize: 16, color: AppColor.inputHintColor),
                        children: [
                      TextSpan(
                          text: "${issue.id}-${issue.subject}",
                          style: TextStyle(
                            color: AppColor.greenColor,
                            fontSize: 14,
                          ))
                    ])),
                CountdownNumber(
                  controller: _controller,
                  seconds: 30 * 60,
                  build: (
                    _,
                    String time,
                  ) {
                    return Text(
                      time,
                      style: TextStyle(
                        fontSize: 50,
                        color: AppColor.white,
                      ),
                    );
                  },
                  interval: const Duration(seconds: 1),
                  onFinished: () => handleDoneCallback.call(issue.id),
                ),
                if (!isStarted)
                  StartTimerButton(
                    onStart: () {
                      _controller.start();
                      setState(() {
                        isStarted = true;
                      });
                    },
                  ),
                if (isStarted)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StartTimerButton(
                        title: "Reset",
                        color: AppColor.erroBorder,
                        onStart: () {
                          _controller.reset();
                          setState(() {
                            isStarted = false;
                          });
                        },
                      ),
                      SizedBox(width: AppLayout.getWidth(context, 10)),
                      StartTimerButton(
                        title: "Pause",
                        color: AppColor.blueColor,
                        onStart: () {
                          _controller.pause();
                        },
                      ),
                    ],
                  ),
              ],
            ),
          );
        }
        return SizedBox(
          height: AppLayout.getHeight(context, 80),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Select issue for starting using Pomodoro functionality",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.inputHintColor,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        );
      },
    );
  }
}

class PomodoroInputField extends StatelessWidget {
  const PomodoroInputField(
      {super.key, this.isDisable = false, this.controller});
  final bool isDisable;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isDisable,
      autofocus: true,
      controller: controller,
      style: TextStyle(color: AppColor.white, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.inputActiveBorder, width: 1),
        ),
      ),
    );
  }
}

class StartTimerButton extends StatelessWidget {
  const StartTimerButton({
    super.key,
    this.onStart,
    this.title = "Start",
    this.color,
  });
  final GestureTapCallback? onStart;
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onStart,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: color ?? AppColor.btnBg, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: color ?? AppColor.greenColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
