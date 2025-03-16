import 'dart:ui';

import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_metrics_controller.dart';

enum TmtTestStateFlow {
  READY,
  TMT_A_IN_PROGRESS,
  TMT_A_COMPLETED,
  TMT_B_IN_PROGRESS,
  TEST_COMPLETED
}

class TmtTestFlowStateController extends GetxController {
  // Shared metrics controller
  TmtMetricsController _metricsController = TmtMetricsController();
  late TmtMetricsController _metricsControllerTmtA;

  // Observable test state
  final Rx<TmtTestStateFlow> testState = TmtTestStateFlow.READY.obs;

  get metricsController => _metricsController;

  void startTest() {
    switch (testState.value) {
      case TmtTestStateFlow.READY:
      case TmtTestStateFlow.TMT_A_IN_PROGRESS:
        _metricsController.onTestStart(TmtTestStateFlow.TMT_A_IN_PROGRESS);
        testState.value = TmtTestStateFlow.TMT_A_IN_PROGRESS;
        break;
      case TmtTestStateFlow.TMT_A_COMPLETED:
      case TmtTestStateFlow.TMT_B_IN_PROGRESS:
        _metricsController.onTestStart(TmtTestStateFlow.TMT_B_IN_PROGRESS);
        testState.value = TmtTestStateFlow.TMT_B_IN_PROGRESS;
        break;
      default:
        break;
    }
  }

  void onTestEnd(Offset lastDragOffset) {
    switch (testState.value) {
      case TmtTestStateFlow.TMT_A_IN_PROGRESS:
        _metricsController.onTestEnd(
            lastDragOffset, TmtTestStateFlow.TMT_A_COMPLETED);
        testState.value = TmtTestStateFlow.TMT_A_COMPLETED;
        _metricsControllerTmtA = _metricsController.copy();
        break;
      case TmtTestStateFlow.TMT_B_IN_PROGRESS:
        _metricsController.onTestEnd(
            lastDragOffset, TmtTestStateFlow.TEST_COMPLETED);
        testState.value = TmtTestStateFlow.TEST_COMPLETED;
        break;
      default:
        break;
    }
  }

  void resetStatusTmtA() {
    _metricsController = TmtMetricsController();
    testState.value = TmtTestStateFlow.TMT_A_IN_PROGRESS;
  }

  void resetStatusTmtB() {
    _metricsController = _metricsControllerTmtA.copy();
    testState.value = TmtTestStateFlow.TMT_B_IN_PROGRESS;
  }

  int getTmtATimeInSec() {
    return _metricsControllerTmtA.testTimeMetrics
        .calculateTimeCompleteTmtA()
        .inSeconds;
  }
}
