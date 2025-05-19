import 'dart:ui';

import 'package:get/get.dart';

import '../../domain/entities/tmt_game/tmt_game_variable.dart';
import '../../domain/usecases/tmt_game_config_use_case.dart';
import 'base_tmt_test_flow_contoller.dart';

class TmtTestFlowStateController extends BaseTmtTestFlowController {
  late TmtGameConfigUseCase tmtGameConfigUseCase;

  @override
  Future<bool> initializeGameConfig() async {
    isConfigLoaded.value = false;
    tmtGameConfigUseCase = Get.find<TmtGameConfigUseCase>();
    try {
      await TmtGameVariables.setTestModeCalculate(tmtGameConfigUseCase);
      isConfigLoaded.value = true;
      return true;
    } catch (e) {
      isConfigLoaded.value = true;
    }
    return false;
  }

  @override
  void handleTestEnd(Offset lastDragOffset, TmtTestStateFlow newState) {
    tmtTestNavigationFlowController.testEnd(lastDragOffset,newState);
  }

  @override
  void handleResetTmtA() {
    tmtTestNavigationFlowController.handleResetTmtA();
  }

  @override
  void handleResetTmtB() {
    tmtTestNavigationFlowController.handleResetTmtB();
  }

  int getTmtATimeInSec() {
    return tmtTestNavigationFlowController.getTmtATimeInSec();
  }
}
