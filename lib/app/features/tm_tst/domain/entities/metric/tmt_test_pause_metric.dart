import 'dart:async';
import 'dart:ui';

import 'metric_static_values.dart';

/// In our experiments we determined a pause to be any time exceeding 0.1 seconds
/// that the user held the stylus in the same place on the screen.
/// The tolerance area of 5 pixels and this pause threshold of 0.1 seconds
/// were determined based on clinical analysis of the dTMT during the initial six design iterations

class TmtTestPauseMetric {
  static const Duration _pauseThresholdDuration =
      Duration(milliseconds: MetricStaticValues.PAUSE_THRESHOLD_MS);

  int numberPause = 0;
  DateTime? _pauseStartTime;
  Offset? _lastPosition;
  Timer? _pauseTimerCounter;
  bool _isPaused = false;
  Duration _totalPauseTime = Duration.zero;

  double calculateAveragePause() {
    return numberPause > 0 ? _totalPauseTime.inMilliseconds / numberPause : 0;
  }

  void onStartPause(Offset startPosition) {
    _lastPosition = startPosition;
    _startTimer();
  }

  void _startTimer() {
    _pauseTimerCounter?.cancel();
    _pauseTimerCounter = Timer(_pauseThresholdDuration, _onStayDetected);
  }

  void _onStayDetected() {
    numberPause++;
    _pauseStartTime = DateTime.now().subtract(_pauseThresholdDuration);
    _isPaused = true;
  }

  void onEndPause() {
    if (_pauseStartTime != null) {
      _totalPauseTime += DateTime.now().difference(_pauseStartTime!);
      _pauseStartTime = null;
    }
    _pauseTimerCounter?.cancel();
    _pauseTimerCounter = null;
  }

  void checkPauseStatus(Offset currentPosition) {
    if (_lastPosition == null) {
      _lastPosition = currentPosition;
      return;
    }

    double distance = (currentPosition - _lastPosition!).distance;

    if (distance > MetricStaticValues.PAUSE_POSITION_TOLERANCE) {
      if (_isPaused) {
        _isPaused = false;
        if (_pauseStartTime != null) {
          _totalPauseTime += DateTime.now().difference(_pauseStartTime!);
        }
        _pauseStartTime = null;
      }

      _lastPosition = currentPosition;
      _startTimer();
    }
  }
}
