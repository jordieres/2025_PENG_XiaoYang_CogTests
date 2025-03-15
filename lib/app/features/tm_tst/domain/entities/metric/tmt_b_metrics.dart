import 'dart:ui';

import '../tmt_game_circle.dart';
import 'circles_metric.dart';

class TmtBMetrics {
  final List<CirclesMetric> _beforeLetterMetricsList = [];
  final List<CirclesMetric> _beforeNumberMetricsList = [];

  DateTime? _connectCircleStartTime;
  Offset? _lastCircleConnectPoint;

  void onConnectLetterCircle(TmtGameCircle circleConnectPoint) {
    if (circleConnectPoint.isFirst()) {
      _connectCircleStartTime = DateTime.now();
      _lastCircleConnectPoint = circleConnectPoint.offset;
    } else {
      final currentTime = DateTime.now();
      CirclesMetric circlesMetric = CirclesMetric();
      circlesMetric.duration =
          currentTime.difference(_connectCircleStartTime!).inMilliseconds;
      circlesMetric.distance =
          (circleConnectPoint.offset - _lastCircleConnectPoint!).distance;

      if (circleConnectPoint.isNumber) {
        _beforeLetterMetricsList.add(circlesMetric);
      } else {
        _beforeNumberMetricsList.add(circlesMetric);
      }

      _connectCircleStartTime = currentTime;
      _lastCircleConnectPoint = circleConnectPoint.offset;
    }
  }

  /// Average Rate Before Letters: The average drawing rate before circles that contain letters (Part B only).
  /// Rate is defined as the straight line distance divided by the time spent drawing the line.
  double calculateAverageRateBeforeLetters() {
    if (_beforeLetterMetricsList.isEmpty) return 0;
    double totalRate = 0.0;
    int count = 0;

    for (var metric in _beforeLetterMetricsList) {
      if (metric.duration > 0) {
        totalRate += (metric.distance / metric.duration);
        count++;
      }
    }

    return count > 0 ? totalRate / count : 0.0;
  }

  /// Average Rate Before Numbers: The average drawing rate before circles that contain numbers (Part B only).
  /// Rate is defined as the straight line distance divided by the time spent drawing the line.
  double calculateAverageRateBeforeNumbers() {
    if (_beforeNumberMetricsList.isEmpty) return 0;
    double totalRate = 0.0;
    int count = 0;

    for (var metric in _beforeNumberMetricsList) {
      if (metric.duration > 0) {
        totalRate += (metric.distance / metric.duration);
        count++;
      }
    }

    return count > 0 ? totalRate / count : 0.0;
  }

  /// Average Time Before Letters: The average drawing time in seconds before circles that contain letters (Part B only).
  double calculateAverageTimeBeforeLetters() {
    if (_beforeLetterMetricsList.isEmpty) return 0;

    final totalTimeBeforeLetters = _beforeLetterMetricsList
        .map((e) => e.duration)
        .reduce((value, element) => value + element);

    return (totalTimeBeforeLetters / _beforeLetterMetricsList.length);
  }

  /// Average Time Before Numbers: The average drawing time in seconds before circles that contain numbers (Part B only).
  double calculateAverageTimeBeforeNumbers() {
    if (_beforeNumberMetricsList.isEmpty) return 0;

    final totalTimeBeforeNumbers = _beforeNumberMetricsList
        .map((e) => e.duration)
        .reduce((value, element) => value + element);

    return (totalTimeBeforeNumbers / _beforeNumberMetricsList.length);
  }
}
