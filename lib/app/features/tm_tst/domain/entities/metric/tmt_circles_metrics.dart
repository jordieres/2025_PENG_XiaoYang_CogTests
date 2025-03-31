import 'dart:ui';

import 'package:logging/logging.dart';
import 'package:msdtmt/app/utils/services/app_logger.dart';

import '../tmt_game_circle.dart';
import '../tmt_game_variable.dart';
import 'circles_metric.dart';
import 'metric_static_values.dart';

class TmtCircleMetrics {
  final List<CirclesMetric> _circleBetweenMetricsList = [];
  final List<CirclesMetric> _circleInsideMetricsList = [];

  final List<Offset> _currentInsideCirclePoints = [];

  DateTime? _connectCircleStartTime;
  Offset? lastCircleConnectPoint;

  DateTime? _insideCircleStartTime;
  Offset? _pointStartInsideCircle;

  bool _isStartDrawInsideCircle = false;

  TmtCircleMetrics copy() {
    TmtCircleMetrics metrics = TmtCircleMetrics();

    for (var metric in _circleBetweenMetricsList) {
      metrics._circleBetweenMetricsList.add(metric.copy());
    }

    for (var metric in _circleInsideMetricsList) {
      metrics._circleInsideMetricsList.add(metric.copy());
    }

    if (_connectCircleStartTime != null) {
      metrics._connectCircleStartTime = DateTime.fromMillisecondsSinceEpoch(
          _connectCircleStartTime!.millisecondsSinceEpoch);
    }

    if (lastCircleConnectPoint != null) {
      metrics.lastCircleConnectPoint =
          Offset(lastCircleConnectPoint!.dx, lastCircleConnectPoint!.dy);
    }

    if (_insideCircleStartTime != null) {
      metrics._insideCircleStartTime = DateTime.fromMillisecondsSinceEpoch(
          _insideCircleStartTime!.millisecondsSinceEpoch);
    }

    if (_pointStartInsideCircle != null) {
      metrics._pointStartInsideCircle =
          Offset(_pointStartInsideCircle!.dx, _pointStartInsideCircle!.dy);
    }

    metrics._isStartDrawInsideCircle = _isStartDrawInsideCircle;

    return metrics;
  }

  void onConnectNextCircleCorrect(int circleIndex, Offset circleConnectPoint) {
    if (circleIndex == 0) {
      _connectCircleStartTime = DateTime.now();
      lastCircleConnectPoint = circleConnectPoint;
    } else {
      final currentTime = DateTime.now();
      CirclesMetric circlesMetric = CirclesMetric();
      circlesMetric.duration =
          currentTime.difference(_connectCircleStartTime!).inMilliseconds;

      double centerToCenterDistance = (circleConnectPoint - lastCircleConnectPoint!).distance;
      double radius = TmtGameVariables.circleRadius;
      /// Rate is defined as the straight line distance between the exit point of one circle
      /// and the entry point of the next
      circlesMetric.distance = centerToCenterDistance - 2 * radius;
      _circleBetweenMetricsList.add(circlesMetric);
      _connectCircleStartTime = currentTime;
      lastCircleConnectPoint = circleConnectPoint;
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
        totalRate += (metric.distance /
            (metric.duration / MetricStaticValues.SEND_METRIC_THRESHOLD_MS));
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
    return (totalTimeBetweenCircles /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS) /
        _circleBetweenMetricsList.length;
  }

  void dragOnInsideCircle(Offset pointStart) {
    if (!_isStartDrawInsideCircle) {
      _insideCircleStartTime = DateTime.now();
      _pointStartInsideCircle = pointStart;
      _isStartDrawInsideCircle = true;
      _currentInsideCirclePoints.clear();
      _currentInsideCirclePoints.add(pointStart);
    } else {
      _currentInsideCirclePoints.add(pointStart);
    }
  }


  void dragEndInsideCircle(Offset pointEnd) {
    if (_insideCircleStartTime == null) return;
    if (_isStartDrawInsideCircle) {
      final currentTime = DateTime.now();
      _currentInsideCirclePoints.add(pointEnd);
      double totalPathLength = 0;
      for (int i = 1; i < _currentInsideCirclePoints.length; i++) {
        totalPathLength += (_currentInsideCirclePoints[i] - _currentInsideCirclePoints[i-1]).distance;
      }

      CirclesMetric circlesMetric = CirclesMetric();
      circlesMetric.duration =
          currentTime.difference(_insideCircleStartTime!).inMilliseconds;
      circlesMetric.distance = totalPathLength;

      _circleInsideMetricsList.add(circlesMetric);
      _isStartDrawInsideCircle = false;
      _insideCircleStartTime = null;

      _currentInsideCirclePoints.clear();
    }
  }

  ///Average Time Inside Circles: Average time in seconds spent drawing inside circles.
  double calculateAverageRateInsideCircles() {
    if (_circleInsideMetricsList.isEmpty) return 0;
    double totalRate = 0.0;
    int count = 0;
    for (var metric in _circleInsideMetricsList) {
      if (metric.duration > 0) {
        totalRate += (metric.distance /
            (metric.duration / MetricStaticValues.SEND_METRIC_THRESHOLD_MS));
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
    return (totalTimeInsideCircles /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS) /
        _circleInsideMetricsList.length;
  }
}
