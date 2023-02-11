import 'package:flutter/widgets.dart';

///
/// Controller for Count down
///
class CountdownNumberController {
  /// Called when called `pause` method
  VoidCallback? onPause;

  /// Called when called `resume` method
  VoidCallback? onResume;

  /// Called when restarting the timer
  VoidCallback? onRestart;

  /// Called when timer is staring
  VoidCallback? onStart;

  /// Called when timer is reset to initial value
  VoidCallback? onReset;

  ///
  /// Checks if the timer is running and enables you to take actions
  /// according to that. if the timer is still active,
  ///
  /// `isCompleted` returns `false` and vice versa.
  ///
  /// for example:
  ///
  /// ``` dart
  ///   _controller.isCompleted ? _controller.restart() : _controller.pause();
  /// ```
  ///
  bool? isCompleted;

  /// if timer auto start.
  final bool autoStart;

  ///
  /// Constructor
  ///
  CountdownNumberController({this.autoStart = false});

  ///
  /// Run timer
  ///
  start() {
    if (onStart != null) {
      onStart!();
    }
  }

  /// Set onStart callback
  setOnStart(VoidCallback onStart) {
    this.onStart = onStart;
  }

  ///
  /// Set timer in pause
  ///
  pause() {
    if (onPause != null) {
      onPause!();
    }
  }

  ///
  /// Reset timer to initial value
  ///
  reset() {
    if (onReset != null) {
      onReset!();
    }
  }

  /// Set onPause callback
  setOnPause(VoidCallback onPause) {
    this.onPause = onPause;
  }

  ///
  /// Resume from pause
  ///
  resume() {
    if (onResume != null) {
      onResume!();
    }
  }

  /// Set onResume callback
  setOnResume(VoidCallback onResume) {
    this.onResume = onResume;
  }

  ///
  /// Restart timer from cold
  ///
  restart() {
    if (onRestart != null) {
      onRestart!();
    }
  }

  /// set onRestart callback
  setOnRestart(VoidCallback onRestart) {
    this.onRestart = onRestart;
  }

  /// set onReset callback
  setOnReset(VoidCallback onReset) {
    this.onReset = onReset;
  }
}
