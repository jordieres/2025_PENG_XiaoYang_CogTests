import 'dart:ui';

import 'package:get/get.dart';

import '../../domain/entities/metric/tmt_metrics_controller.dart';
import '../newscreens/tmt_test_navigation_flow.dart';

enum TmtTestStateFlow {
  READY,
  TMT_A_IN_PROGRESS,
  TMT_A_COMPLETED,
  TMT_B_IN_PROGRESS,
  TEST_COMPLETED
}

abstract class BaseTmtTestFlowController extends GetxController {
  final Rx<TmtTestStateFlow> testState = TmtTestStateFlow.READY.obs;

  TmtTestNavigationFlowController tmtTestNavigationFlowController =
      Get.find<TmtTestNavigationFlowController>();
  final RxBool isConfigLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeGameConfig();
  }

  Future<bool> initializeGameConfig();

  void startTest() {
    switch (testState.value) {
      case TmtTestStateFlow.READY:
      case TmtTestStateFlow.TMT_A_IN_PROGRESS:
        tmtTestNavigationFlowController.testStart();
        testState.value = TmtTestStateFlow.TMT_A_IN_PROGRESS;
        break;
      case TmtTestStateFlow.TMT_A_COMPLETED:
      case TmtTestStateFlow.TMT_B_IN_PROGRESS:
        tmtTestNavigationFlowController.testStart();
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

  TmtMetricsController getMetricsController() {
    return tmtTestNavigationFlowController.metricsController;
  }

  TmtTestNavigationFlow getTmtTestNavigationFlow() {
    return tmtTestNavigationFlowController.tmtTestFlowState.value;
  }

  void handleTestEnd(Offset lastDragOffset, TmtTestStateFlow newState);

  void handleResetTmtA();

  void handleResetTmtB();
}
