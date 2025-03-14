import 'package:flutter/cupertino.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_b_metrics.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_circles_metrics.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_lift_metric.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_pause_metric.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_test_time_metric.dart';

enum TmtGameTypeMetrics { typeA, typeB }

class TmtMetricsController {
  bool isFinishTest = false;
  int numberError = 0;
  List<double> pressureList = [];
  List<double> sizeList = [];

  TmtTestLiftMetric testLiftMetric = TmtTestLiftMetric();
  TmtTestPauseMetric testPauseMetric = TmtTestPauseMetric();
  TmtTestTimeMetric testTime = TmtTestTimeMetric();
  TmtCircleMetrics circleMetrics = TmtCircleMetrics();
  TmtBMetrics bMetrics = TmtBMetrics();

  void onTestStart(TmtGameTypeMetrics type) {
    testTime.timeStartTest = DateTime.now();
    if (type == TmtGameTypeMetrics.typeA) {
      testTime.timeStartTmtA = DateTime.now();
    } else {
      testTime.timeStartTmtB = DateTime.now();
    }
  }

  void onTestEnd() {
    testTime.timeEndTest = DateTime.now();
    isFinishTest = true;
  }

  // Finger touch screen
  void onPanStart(DragStartDetails details) {
    testLiftMetric.onEndLift();
  }

  // Finger move screen
  void onPanUpdate(DragUpdateDetails details) {}

  // Finger lift screen
  void onPanEnd(DragEndDetails details) {
    testLiftMetric.onStartLift();
  }

  void onConnectNextCircleCorrect() {}

  void onConnectNextCircleError() {
    numberError++;
  }

  void onPointerMove(PointerMoveEvent event) {
    // Implementation logic for pointer movement
  }
}
