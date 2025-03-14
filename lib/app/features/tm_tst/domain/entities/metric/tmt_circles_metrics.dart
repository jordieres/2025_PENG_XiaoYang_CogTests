import 'dart:ui';

import 'circles_metric.dart';

class TmtCircleMetrics {

  static const MS_IN_SECOND = 1000;

  List<CirclesMetric> circleBetweenMetrics = [];

  DateTime? startTime;
  Offset? lastCircleConnectPoint;

  void onConnectNextCircleCorrect(int circleIndex, Offset circleConnectPoint) {
    if (circleIndex == 0) {
      startTime = DateTime.now();
      lastCircleConnectPoint = circleConnectPoint;
    } else {
      final currentTime = DateTime.now();
      CirclesMetric circlesMetric = CirclesMetric();
      circlesMetric.duration =
          currentTime.difference(startTime!).inMilliseconds;
      circlesMetric.distance =
          (circleConnectPoint - lastCircleConnectPoint!).distance;
      startTime = currentTime;
      circleBetweenMetrics.add(circlesMetric);
    }
  }

  /// Average Rate Between Circles: Drawing rate between circles.
  /// Rate is defined as the straight line distance between the exit point of one circle
  /// and the entry point of the next,
  /// divided by the time spent drawing the line from one circle to the next.
  double calculateAverageRateBetweenCircles() {
    if (circleBetweenMetrics.isEmpty) return 0;
    double totalRate = 0.0;
    int count = 0;
    for (var metric in circleBetweenMetrics) {
      if (metric.duration > 0) {
        totalRate += (metric.distance / metric.duration) * MS_IN_SECOND;
        count++;
      }
    }
    return count > 0 ? totalRate / count : 0.0;
  }

  double calculateAverageRateInsideCircles() {
    return 0;
  }

  double calculateAverageTimeBetweenCircles() {
    if (circleBetweenMetrics.isEmpty) return 0;
    final totalTimeBetweenCircles = circleBetweenMetrics
        .map((e) => e.duration)
        .reduce((value, element) => value + element);
    return totalTimeBetweenCircles / circleBetweenMetrics.length;
  }

  double calculateAverageTimeInsideCircles() {
    // For future implementation if needed
    return 0;
  }
}
