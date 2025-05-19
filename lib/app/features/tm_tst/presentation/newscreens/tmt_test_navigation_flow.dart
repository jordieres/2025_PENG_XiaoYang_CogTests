import 'dart:ui';

import 'package:get/get.dart';
import 'package:msdtmt/app/utils/services/app_logger.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/result/tmt_game_hand_used.dart';

import '../../../../utils/mixins/app_mixins.dart';
import '../../domain/entities/metric/tmt_metrics_controller.dart';
import '../../domain/entities/result/tmt_game_init_data.dart';
import '../../domain/entities/tmt_game/tmt_game_before_data.dart';
import '../controllers/base_tmt_test_flow_contoller.dart';
import '../screens/tmt_test_help.dart';
import '../screens/tmt_test_practice_screen.dart';
import '../screens/tmt_test_screen.dart';

enum TmtTestNavigationFlow {
  START,
  TMT_A_PRACTICE_IN_PROCESS,
  TMT_A_IN_PROGRESS,
  TMT_A_COMPLETED,
  TMT_B_PRACTICE_IN_PROCESS,
  TMT_B_IN_PROGRESS,
  TEST_COMPLETED
}

class TmtTestNavigationFlowController extends GetxController
    with NavigationMixin {
  final Rx<TmtTestNavigationFlow> tmtTestFlowState =
      TmtTestNavigationFlow.START.obs;

  late TmtGameInitData tmtGameInitData;
  late TmtGameBeforeData tmtGameBeforeData;

  TmtMetricsController metricsController = TmtMetricsController();
  late TmtMetricsController _metricsControllerTmtA;

  void begin(TmtGameBeforeData tmtGameBeforeData) {
    this.tmtGameBeforeData = tmtGameBeforeData;
    tmtTestFlowState.value = TmtTestNavigationFlow.START;
    _handleStateChangeForNavigation(tmtTestFlowState.value);
  }

  void testStart() {
    metricsController.onTestStart(tmtTestFlowState.value);
  }

  void testEnd(Offset lastDragOffset, TmtTestStateFlow tmtTestState) {
    metricsController.onTestEnd(lastDragOffset, tmtTestState);
  }

  void handleResetTmtA() {
    final timeStartTest = metricsController.testTimeMetrics.timeStartTest;
    final newMetricsController = TmtMetricsController();
    newMetricsController
        .setCurrentTmtTestNavigationFlow(tmtTestFlowState.value);
    newMetricsController.setTimeStartTest(timeStartTest ?? DateTime.now());
    metricsController = newMetricsController;
  }

  void handleResetTmtB() {
    metricsController = _metricsControllerTmtA.copy();
    metricsController.setCurrentTmtTestNavigationFlow(tmtTestFlowState.value);
  }

  int getTmtATimeInSec() {
    return _metricsControllerTmtA.testTimeMetrics
        .calculateTimeCompleteTmtA()
        .round();
  }

  void _handleStateChangeForNavigation(TmtTestNavigationFlow newState) {
    switch (newState) {
      case TmtTestNavigationFlow.START:
        metricsController.onTestStart(tmtTestFlowState.value);
        break;
      case TmtTestNavigationFlow.TMT_A_PRACTICE_IN_PROCESS:
        navigateToPractice(TMTTestPracticeMode.TMT_A_ONLY);
        break;
      case TmtTestNavigationFlow.TMT_A_IN_PROGRESS:
        toTmtTest(TmtType.tmtA);
        break;
      case TmtTestNavigationFlow.TMT_A_COMPLETED:
        _metricsControllerTmtA = metricsController.copy();
        tmtTestToHelp(TmtHelpMode.TMT_TEST_B, true);
        break;
      case TmtTestNavigationFlow.TMT_B_PRACTICE_IN_PROCESS:
        navigateToPractice(TMTTestPracticeMode.TMT_B_ONLY);
        break;
      case TmtTestNavigationFlow.TMT_B_IN_PROGRESS:
        toTmtTest(TmtType.tmtB);
        break;
      case TmtTestNavigationFlow.TEST_COMPLETED:
        navigateToResultScreen(tmtGameInitData);
        break;
    }
    metricsController.setCurrentTmtTestNavigationFlow(tmtTestFlowState.value);
  }

  void advanceState() {
    TmtTestNavigationFlow nextState;
    switch (tmtTestFlowState.value) {
      case TmtTestNavigationFlow.START:
        nextState = TmtTestNavigationFlow.TMT_A_PRACTICE_IN_PROCESS;
        break;
      case TmtTestNavigationFlow.TMT_A_PRACTICE_IN_PROCESS:
        nextState = TmtTestNavigationFlow.TMT_A_IN_PROGRESS;
        break;
      case TmtTestNavigationFlow.TMT_A_IN_PROGRESS:
        nextState = TmtTestNavigationFlow.TMT_A_COMPLETED;
        break;
      case TmtTestNavigationFlow.TMT_A_COMPLETED:
        nextState = TmtTestNavigationFlow.TMT_B_PRACTICE_IN_PROCESS;
        break;
      case TmtTestNavigationFlow.TMT_B_PRACTICE_IN_PROCESS:
        nextState = TmtTestNavigationFlow.TMT_B_IN_PROGRESS;
        break;
      case TmtTestNavigationFlow.TMT_B_IN_PROGRESS:
        nextState = TmtTestNavigationFlow.TEST_COMPLETED;
        break;
      case TmtTestNavigationFlow.TEST_COMPLETED:
        AppLogger.debug("TmtTestNavigationFlowController",
            "Already at the last state: TEST_COMPLETED");
        return;
    }
    tmtTestFlowState.value = nextState;
    _handleStateChangeForNavigation(nextState);
  }

  void saveTmtGameInitData(TmtGameHandUsed tmtGameHandUsed) {
    tmtGameInitData = TmtGameInitData(
      tmtGameHandUsed: tmtGameHandUsed,
      tmtGameCodeId: tmtGameBeforeData.tmtGameCodeId,
    );
  }
}
