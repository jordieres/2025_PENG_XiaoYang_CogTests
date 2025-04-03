import 'dart:ui';

import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/tmt_metrics_controller.dart';

import '../../domain/entities/tmt_game/tmt_game_variable.dart';
import 'base_tmt_test_flow_contoller.dart';

class TmtTestFlowStateController extends BaseTmtTestFlowController {
  late TmtMetricsController _metricsControllerTmtA;

  @override
  void handleTestStart(TmtTestStateFlow newState) {
    metricsController.onTestStart(newState);
    TmtGameVariables.setTestModeCalculate();
  }

  @override
  void handleTestEnd(Offset lastDragOffset, TmtTestStateFlow newState) {
    metricsController.onTestEnd(lastDragOffset, newState);

    if (newState == TmtTestStateFlow.TMT_A_COMPLETED) {
      _metricsControllerTmtA = metricsController.copy();
    }
  }

  @override
  void onTmtACompleted() {
    // This will be called when Part A is completed
    // The dialog will be shown via the observer in the View
  }

  @override
  void handleResetTmtA() {
    metricsController = TmtMetricsController();
  }

  @override
  void handleResetTmtB() {
    metricsController = _metricsControllerTmtA.copy();
  }

  int getTmtATimeInSec() {
    return _metricsControllerTmtA.testTimeMetrics
        .calculateTimeCompleteTmtA().toInt();
  }
}
