import 'dart:ui';

import '../../domain/entities/metric/tmt_metrics_controller.dart';
import '../../domain/entities/tmt_game/tmt_game_variable.dart';
import 'base_tmt_test_flow_contoller.dart';

class TmtPracticeFlowController extends BaseTmtTestFlowController {
  @override
  void handleTestStart(TmtTestStateFlow newState) {
    TmtGameVariables.setPracticeModeCalculate();
  }

  @override
  void handleTestEnd(Offset lastDragOffset, TmtTestStateFlow newState) {
    metricsController = TmtMetricsController();
  }

  @override
  void onTmtACompleted() {}

  @override
  void handleResetTmtA() {}

  @override
  void handleResetTmtB() {}
}
