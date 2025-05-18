import 'dart:ui';
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
  void handleTestEnd(Offset lastDragOffset, TmtTestStateFlow newState) {
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
