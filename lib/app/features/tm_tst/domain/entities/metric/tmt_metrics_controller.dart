import 'package:flutter/cupertino.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_b_metrics.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_circles_metrics.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_pressure_size_metric.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_lift_metric.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_pause_metric.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_time_metric.dart';
import 'package:msdtmt/app/utils/services/app_logger.dart';

import '../../../presentation/controllers/base_tmt_test_flow_contoller.dart';
import '../../../presentation/controllers/tmt_test_flow_state_controller.dart';
import '../tmt_game/tmt_game_circle.dart';

/// All calculation here are in milliseconds
class TmtMetricsController {
  List<TmtGameCircle> circles = [];

  bool isFinishTest = false;
  int numberError = 0;
  int numberErrorA = 0;
  int numberErrorB = 0;

  List<double> pressureList = [];
  List<double> sizeList = [];

  TmtTestLiftMetric testLiftMetric = TmtTestLiftMetric();
  TmtTestPauseMetric testPauseMetric = TmtTestPauseMetric();
  TmtTestTimeMetric testTimeMetrics = TmtTestTimeMetric();
  TmtCircleMetrics circleMetrics = TmtCircleMetrics();
  TmtBMetrics bMetrics = TmtBMetrics();
  TmtPressureSizeMetric pressureSizeMetric = TmtPressureSizeMetric();

  TmtMetricsController copy() {
    TmtMetricsController controller = TmtMetricsController();
    controller.isFinishTest = isFinishTest;
    controller.numberError = numberError;
    controller.numberErrorA = numberErrorA;
    controller.numberErrorB = numberErrorB;
    controller.circles = List<TmtGameCircle>.from(circles);
    controller.pressureList = List<double>.from(pressureList);
    controller.sizeList = List<double>.from(sizeList);
    controller.testLiftMetric = testLiftMetric.copy();
    controller.testPauseMetric = testPauseMetric.copy();
    controller.testTimeMetrics = testTimeMetrics.copy();
    controller.circleMetrics = circleMetrics.copy();
    controller.bMetrics = bMetrics.copy();
    controller.pressureSizeMetric = pressureSizeMetric.copy();
    return controller;
  }

  void onTestStart(TmtTestStateFlow tmtTestState) {
    switch (tmtTestState) {
      case TmtTestStateFlow.READY:
      case TmtTestStateFlow.TMT_A_IN_PROGRESS:
        final currentTestTime = DateTime.now();
        testTimeMetrics.timeStartTest = currentTestTime;
        testTimeMetrics.timeStartTmtA = currentTestTime;
        break;
      case TmtTestStateFlow.TMT_B_IN_PROGRESS:
        testTimeMetrics.timeStartTmtB = DateTime.now();
        break;
      default:
        break;
    }
  }

  void onTestEnd(Offset lastDragOffset, TmtTestStateFlow tmtTestState) {
    switch (tmtTestState) {
      case TmtTestStateFlow.TMT_A_COMPLETED:
        testTimeMetrics.timeEndTmtA = DateTime.now();
        break;
      case TmtTestStateFlow.TEST_COMPLETED:
        final currentTestTime = DateTime.now();
        testTimeMetrics.timeEndTmtB = currentTestTime;
        testTimeMetrics.timeEndTest = currentTestTime;
        break;
      default:
        break;
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

  void onConnectNextCircleCorrect(int circleIndex,
      TmtGameCircle circleConnectPoint, TmtTestStateFlow tmtTestState) {
    circleMetrics.onConnectNextCircleCorrect(
        circleIndex, circleConnectPoint.offset);

    int circleNumber = circleIndex + 1;
    if (tmtTestState == TmtTestStateFlow.TMT_A_IN_PROGRESS ||
        tmtTestState == TmtTestStateFlow.READY) {
      testTimeMetrics.recordTmtACircleTime(circleNumber);
    } else if (tmtTestState == TmtTestStateFlow.TMT_B_IN_PROGRESS) {
      testTimeMetrics.recordTmtBCircleTime(circleNumber);
      bMetrics.onConnectLetterCircle(circleConnectPoint);
    }
  }

  void onConnectNextCircleError(TmtTestStateFlow tmtTestState) {
    numberError++;
    if (tmtTestState == TmtTestStateFlow.TMT_A_IN_PROGRESS) {
      numberErrorA++;
    } else if (tmtTestState == TmtTestStateFlow.TMT_B_IN_PROGRESS) {
      numberErrorB++;
    }
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