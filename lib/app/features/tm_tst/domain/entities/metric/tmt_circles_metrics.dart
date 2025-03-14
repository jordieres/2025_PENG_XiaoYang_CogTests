import 'dart:ui';

import 'circles_metric.dart';

class TmtCircleMetrics {
  final List<CirclesMetric> _circleBetweenMetricsList = [];
  final List<CirclesMetric> _circleInsideMetricsList = [];

  DateTime? _connectCircleStartTime;
  Offset? lastCircleConnectPoint;

  DateTime? _insideCircleStartTime;
  Offset? _pointStartInsideCircle;

  bool _isStartDrawInsideCircle = false;

  void onConnectNextCircleCorrect(int circleIndex, Offset circleConnectPoint) {
    if (circleIndex == 0) {
      _connectCircleStartTime = DateTime.now();
      lastCircleConnectPoint = circleConnectPoint;
    } else {
      final currentTime = DateTime.now();
      CirclesMetric circlesMetric = CirclesMetric();
      circlesMetric.duration =
          currentTime.difference(_connectCircleStartTime!).inMilliseconds;
      circlesMetric.distance =
          (circleConnectPoint - lastCircleConnectPoint!).distance;
      _connectCircleStartTime = currentTime;
      _circleBetweenMetricsList.add(circlesMetric);
    }
  }

  /// Average Rate Between Circles: Drawing rate between circles.
  /// Rate is defined as the straight line distance between the exit point of one circle
  /// and the entry point of the next,
  /// divided by the time spent drawing the line from one circle to the next.
  double calculateAverageRateBetweenCircles() {
    if (_circleBetweenMetricsList.isEmpty) return 0;
    double totalRate = 0.0;
    int count = 0;
    for (var metric in _circleBetweenMetricsList) {
      if (metric.duration > 0) {
        totalRate += (metric.distance / metric.duration);
        count++;
      }
    }
    return count > 0 ? totalRate / count : 0.0;
  }

  double calculateAverageTimeBetweenCircles() {
    if (_circleBetweenMetricsList.isEmpty) return 0;
    final totalTimeBetweenCircles = _circleBetweenMetricsList
        .map((e) => e.duration)
        .reduce((value, element) => value + element);
    return totalTimeBetweenCircles / _circleBetweenMetricsList.length;
  }

  void dragOnInsideCircle(Offset pointStart) {
    if (!_isStartDrawInsideCircle) {
      _insideCircleStartTime = DateTime.now();
      _pointStartInsideCircle = pointStart;
      _isStartDrawInsideCircle = true;
    }
  }

  void dragEndInsideCircle(Offset pointEnd) {
    if (_insideCircleStartTime == null) return;
    if (_isStartDrawInsideCircle) {
      final currentTime = DateTime.now();
      CirclesMetric circlesMetric = CirclesMetric();
      circlesMetric.duration =
          currentTime.difference(_insideCircleStartTime!).inMilliseconds;
      circlesMetric.distance = (pointEnd - _pointStartInsideCircle!).distance;
      _circleInsideMetricsList.add(circlesMetric);
      _isStartDrawInsideCircle = false;
      _insideCircleStartTime = null;
    }
  }

  ///Average Time Inside Circles: Average time in seconds spent drawing inside circles.
  double calculateAverageRateInsideCircles() {
    if (_circleInsideMetricsList.isEmpty) return 0;
    double totalRate = 0.0;
    int count = 0;
    for (var metric in _circleInsideMetricsList) {
      if (metric.duration > 0) {
        totalRate += (metric.distance / metric.duration);
        count++;
      }
    }
    return count > 0 ? totalRate / count : 0.0;
  }

  ///Average Rate Inside Circles: The average drawing rate inside each circle.
  double calculateAverageTimeInsideCircles() {
    if (_circleInsideMetricsList.isEmpty) return 0;
    final totalTimeInsideCircles = _circleInsideMetricsList
        .map((e) => e.duration)
        .reduce((value, element) => value + element);
    return totalTimeInsideCircles / _circleInsideMetricsList.length;
  }
}
