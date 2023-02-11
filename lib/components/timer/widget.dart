import 'dart:async';
import 'package:flutter/widgets.dart';
import './controller.dart';
export './controller.dart';

///
/// Simple countdownNumber timer.
///
class CountdownNumber extends StatefulWidget {
  /// Length of the timer
  final int seconds;

  /// Build method for the timer
  final Widget Function(BuildContext, String) build;

  /// Called when finished
  final Function? onFinished;

  /// Build interval
  final Duration interval;

  /// Controller
  final CountdownNumberController? controller;

  ///
  /// Simple countdownNumber timer
  ///
  const CountdownNumber({
    Key? key,
    required this.seconds,
    required this.build,
    this.interval = const Duration(seconds: 1),
    this.onFinished,
    this.controller,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CountdownNumberState createState() => _CountdownNumberState();
}

///
/// State of timer
///
class _CountdownNumberState extends State<CountdownNumber> {
  // Multiplier of secconds
  final int _secondsFactor = 1000000;

  // Timer
  Timer? _timer;

  /// Internal control to indicate if the onFinished method was executed
  bool _onFinishedExecuted = false;

  /// Internal control to indicate to seconds value decreasing
  int secondsValue = 0;

  // Current seconds
  late int _currentMicroSeconds;

  @override
  void initState() {
    _currentMicroSeconds = widget.seconds * _secondsFactor;

    widget.controller?.setOnStart(_startTimer);
    widget.controller?.setOnReset(_onTimerReset);
    widget.controller?.setOnPause(_onTimerPaused);
    widget.controller?.setOnResume(_onTimerResumed);
    widget.controller?.setOnRestart(_onTimerRestart);
    widget.controller?.isCompleted = false;

    if (widget.controller == null || widget.controller!.autoStart == true) {
      _startTimer();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(CountdownNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.seconds != widget.seconds) {
      _currentMicroSeconds = widget.seconds * _secondsFactor;
    }
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondsLeft = _currentMicroSeconds / _secondsFactor;
    final duration = Duration(seconds: secondsLeft.toInt());
    final minutes = (duration.inMinutes).floor();
    return widget.build(
        context, '${preciseDouble(minutes)}:${preciseDouble(secondsValue)}');
  }

  ///
  /// Add precision to two digit
  ///
  String preciseDouble(int value) {
    return value > 9 ? value.toString() : '0$value';
  }

  ///
  /// Then timer paused
  ///
  void _onTimerPaused() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  ///
  /// Then timer resumed
  ///
  void _onTimerResumed() {
    _startTimer();
  }

  ///
  /// Then timer reset
  ///
  void _onTimerReset() {
    _resetTimer();
  }

  ///
  /// Then timer reset
  ///
  void _resetTimer() {
    widget.controller?.isCompleted = false;
    _onFinishedExecuted = false;
    setState(() {
      _currentMicroSeconds = widget.seconds * _secondsFactor;
      secondsValue = 0;
    });
    if (_timer?.isActive == true) {
      _timer!.cancel();

      widget.controller?.isCompleted = true;
    }
  }

  ///
  /// Then timer restarted
  ///
  void _onTimerRestart() {
    widget.controller?.isCompleted = false;
    _onFinishedExecuted = false;

    if (mounted) {
      setState(() {
        _currentMicroSeconds = widget.seconds * _secondsFactor;
        secondsValue = 0;
      });

      _startTimer();
    }
  }

  ///
  /// Start timer
  ///
  void _startTimer() {
    if (_timer?.isActive == true) {
      _timer!.cancel();

      widget.controller?.isCompleted = true;
    }

    if (_currentMicroSeconds != 0) {
      _timer = Timer.periodic(
        widget.interval,
        (Timer timer) {
          if (_currentMicroSeconds <= 0) {
            timer.cancel();

            if (widget.onFinished != null) {
              widget.onFinished!();
              _onFinishedExecuted = true;
            }
            widget.controller?.isCompleted = true;
          } else {
            _onFinishedExecuted = false;
            setState(() {
              secondsValue = secondsValue == 0 ? 59 : secondsValue - 1;
              _currentMicroSeconds =
                  _currentMicroSeconds - widget.interval.inMicroseconds;
            });
          }
        },
      );
    } else if (!_onFinishedExecuted) {
      if (widget.onFinished != null) {
        widget.onFinished!();
        _onFinishedExecuted = true;
      }
      widget.controller?.isCompleted = true;
    }
  }
}
