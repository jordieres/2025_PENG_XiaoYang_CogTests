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
    // Additional implementation logic
  }

  // Finger touch screen
  void onPanStart(DragStartDetails details) {
    // Implementation logic for pan start
    testPauseMetric.onEndPause();
  }

  // Finger move screen
  void onPanUpdate(DragUpdateDetails details) {
    // Implementation logic for pan update
  }

  // Finger lift screen
  void onPanEnd(DragEndDetails details) {
    testPauseMetric.onStartPause();
  }

  void onConnectNextCircleCorrect() {}

  void onConnectNextCircleError() {
    numberError++;
    print('numberError: $numberError');
  }

  void onPointerMove(PointerMoveEvent event) {
    // Implementation logic for pointer movement
  }
}
