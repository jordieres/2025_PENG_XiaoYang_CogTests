import 'dart:ui';

import 'package:get/get.dart';

import '../../domain/entities/metric/tmt_metrics_controller.dart';

enum TmtTestStateFlow {
  READY,
  TMT_A_IN_PROGRESS,
  TMT_A_COMPLETED,
  TMT_B_IN_PROGRESS,
  TEST_COMPLETED
}


abstract class BaseTmtTestFlowController extends GetxController {
  final Rx<TmtTestStateFlow> testState = TmtTestStateFlow.READY.obs;
  TmtMetricsController metricsController = TmtMetricsController();
  void startTest() {
    switch (testState.value) {
      case TmtTestStateFlow.READY:
      case TmtTestStateFlow.TMT_A_IN_PROGRESS:
        handleTestStart(TmtTestStateFlow.TMT_A_IN_PROGRESS);
        testState.value = TmtTestStateFlow.TMT_A_IN_PROGRESS;
        break;
      case TmtTestStateFlow.TMT_A_COMPLETED:
      case TmtTestStateFlow.TMT_B_IN_PROGRESS:
        handleTestStart(TmtTestStateFlow.TMT_B_IN_PROGRESS);
        testState.value = TmtTestStateFlow.TMT_B_IN_PROGRESS;
        break;
      default:
        break;
    }
  }

  void onTestEnd(Offset lastDragOffset) {
    switch (testState.value) {
      case TmtTestStateFlow.TMT_A_IN_PROGRESS:
        handleTestEnd(lastDragOffset, TmtTestStateFlow.TMT_A_COMPLETED);
        testState.value = TmtTestStateFlow.TMT_A_COMPLETED;
        onTmtACompleted(); // Call the method when TMT A is completed
        break;
      case TmtTestStateFlow.TMT_B_IN_PROGRESS:
        handleTestEnd(lastDragOffset, TmtTestStateFlow.TEST_COMPLETED);
        testState.value = TmtTestStateFlow.TEST_COMPLETED;
        break;
      default:
        break;
    }
  }

  void resetStatusTmtA() {
    handleResetTmtA();
    testState.value = TmtTestStateFlow.TMT_A_IN_PROGRESS;
  }

  void resetStatusTmtB() {
    handleResetTmtB();
    testState.value = TmtTestStateFlow.TMT_B_IN_PROGRESS;
  }

  void handleTestStart(TmtTestStateFlow newState);
  void handleTestEnd(Offset lastDragOffset, TmtTestStateFlow newState);
  void onTmtACompleted(); // Abstract method that must be implemented
  void handleResetTmtA();
  void handleResetTmtB();
}