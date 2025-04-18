import 'dart:ui';

import '../../domain/entities/metric/tmt_metrics_controller.dart';
import '../../domain/entities/tmt_game/tmt_game_variable.dart';
import 'base_tmt_test_flow_contoller.dart';

class TmtPracticeFlowController extends BaseTmtTestFlowController {
  @override
  Future<bool> initializeGameConfig() async {
    TmtGameVariables.setPracticeModeCalculate();
    isConfigLoaded.value = true;
    return true;
  }

  @override
  void handleTestStart(TmtTestStateFlow newState) {
    // Nothing additional needed for practice mode
  }

  @override
  void handleTestEnd(Offset lastDragOffset, TmtTestStateFlow newState) {
    metricsController = TmtMetricsController();
  }

  @override
  void onTmtACompleted() {
    // Nothing needed for practice mode
  }

  @override
  void handleResetTmtA() {
    // Nothing needed for reset in practice mode
  }

  @override
  void handleResetTmtB() {
    // Nothing needed for reset in practice mode
  }
}
