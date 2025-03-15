import 'package:flutter/cupertino.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_b_metrics.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_circles_metrics.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_pressure_size_metric.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_lift_metric.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_pause_metric.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_time_metric.dart';

import '../tmt_game_circle.dart';

enum TmtGameTypeMetrics { typeA, typeB }

/// All calculation here are in milliseconds
class TmtMetricsController {
  List<TmtGameCircle> circles = [];

  bool isFinishTest = false;
  int numberError = 0;
  List<double> pressureList = [];
  List<double> sizeList = [];

  TmtTestLiftMetric testLiftMetric = TmtTestLiftMetric();
  TmtTestPauseMetric testPauseMetric = TmtTestPauseMetric();
  TmtTestTimeMetric testTimeMetrics = TmtTestTimeMetric();
  TmtCircleMetrics circleMetrics = TmtCircleMetrics();
  TmtBMetrics bMetrics = TmtBMetrics();
  TmtPressureSizeMetric pressureSizeMetric = TmtPressureSizeMetric();

  void onTestStart(TmtGameTypeMetrics type) {
    testTimeMetrics.timeStartTest = DateTime.now();
    if (type == TmtGameTypeMetrics.typeA) {
      testTimeMetrics.timeStartTmtA = DateTime.now();
    } else {
      final timeNow = DateTime.now();
      testTimeMetrics.timeEndTmtA = timeNow;
      testTimeMetrics.timeStartTmtB = timeNow;
    }
  }

  void onTestEnd(Offset lastDragOffset, TmtGameTypeMetrics type) {
    if (type == TmtGameTypeMetrics.typeB) {
      final timeNow = DateTime.now();
      testTimeMetrics.timeEndTmtB = timeNow;
      testTimeMetrics.timeEndTest = timeNow;
    }
    isFinishTest = true;
    testPauseMetric.onEndPause();
    circleMetrics.dragEndInsideCircle(lastDragOffset);
  }

  // Finger touch screen
  void onPanStart(DragStartDetails details) {
    testLiftMetric.onEndLift();
    testPauseMetric.onStartPause(details.localPosition);
  }

  // Finger move screen
  void onPanUpdate(DragUpdateDetails details, List<TmtGameCircle> circles) {
    final currentPosition = details.localPosition;
    testPauseMetric.checkPauseStatus(currentPosition);

    if (circles.isNotEmpty) {
      TmtGameCircle currentCircle = circles.last;
      if (currentCircle.isPointInsideCircle(details.localPosition)) {
        circleMetrics.dragOnInsideCircle(details.localPosition);
      } else {
        circleMetrics.dragEndInsideCircle(details.localPosition);
      }
    }
  }

  // Finger lift screen
  void onPanEnd(DragEndDetails details) {
    testLiftMetric.onStartLift();
    testPauseMetric.onEndPause();
    circleMetrics.dragEndInsideCircle(details.localPosition);
  }

  void onConnectNextCircleCorrect(
      int circleIndex, TmtGameCircle circleConnectPoint) {
    circleMetrics.onConnectNextCircleCorrect(
        circleIndex, circleConnectPoint.offset);
    bMetrics.onConnectLetterCircle(circleConnectPoint);
  }

  void onConnectNextCircleError() {
    numberError++;
  }

  void onPointerMove(PointerMoveEvent event) {
    if (event.pressure != TmtPressureSizeMetric.noHavePressureCharacteristic) {
      pressureSizeMetric.addPressureValue(event.pressure);
    }

    if (event.size != TmtPressureSizeMetric.noHaveSizeCharacteristic) {
      pressureSizeMetric.addSizeValue(event.size);
    }
  }
}
