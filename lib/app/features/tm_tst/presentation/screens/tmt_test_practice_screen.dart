import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../components/tmt_game_board_controller.dart';
import '../controllers/base_tmt_test_flow_contoller.dart';
import '../controllers/tmt_practice_flow_state_contoller.dart';
import '../newscreens/tmt_test_navigation_flow.dart';

enum TMTTestPracticeMode { TMT_A_ONLY, TMT_B_ONLY }

class TmtTestPracticePage extends StatefulWidget {
  const TmtTestPracticePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TmtPracticePageState();
  }
}

class _TmtPracticePageState extends State<TmtTestPracticePage>
    with NavigationMixin {
  TMTTestPracticeMode tmtTestPracticeMode = TMTTestPracticeMode.TMT_A_ONLY;
  TmtGameBoardController? _boardController;
  late TmtPracticeFlowController _practiceController;
  Worker? _stateWorker;
  late TmtTestNavigationFlowController tmtTestNewFlowController;

  @override
  void initState() {
    super.initState();
    _initPracticeController();
    _tmtPracticeFlowStateObserver();
  }

  void _initPracticeController() {
    _practiceController = Get.find<TmtPracticeFlowController>();
    try {
      tmtTestPracticeMode = Get.arguments as TMTTestPracticeMode;
      tmtTestNewFlowController = Get.find<TmtTestNavigationFlowController>();
    } catch (e) {
      tmtTestPracticeMode = TMTTestPracticeMode.TMT_A_ONLY;
    }

    switch (tmtTestPracticeMode) {
      case TMTTestPracticeMode.TMT_A_ONLY:
        _practiceController.testState.value = TmtTestStateFlow.READY;
        break;
      case TMTTestPracticeMode.TMT_B_ONLY:
        _practiceController.testState.value = TmtTestStateFlow.TMT_A_COMPLETED;
        break;
    }
  }

  void _tmtPracticeFlowStateObserver() {
    _stateWorker = ever(_practiceController.testState, (state) {
      if (!mounted) return;
      if (state == TmtTestStateFlow.TMT_A_COMPLETED) {
        if (tmtTestPracticeMode == TMTTestPracticeMode.TMT_A_ONLY) {
          _showPracticeCompletedADialog();
        }
      } else if (state == TmtTestStateFlow.TEST_COMPLETED) {
        if (tmtTestPracticeMode == TMTTestPracticeMode.TMT_B_ONLY) {
          _showPracticeCompletedBDialog();
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _boardController ??= TmtGameBoardController(
        key: UniqueKey(), flowController: _practiceController);
  }

  @override
  void dispose() {
    _stateWorker?.dispose();
    super.dispose();
  }

  void _showPracticeCompletedADialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        mode: DialogMode.singleButton,
        title: TMTGamePracticesText.tmtGamePracticeCompletedADialogTitle.tr,
        content: TMTGamePracticesText.tmtGamePracticeCompletedADialogContent.tr,
        primaryButtonText:
            TMTGamePracticesText.tmtGamePracticeCompletedADialogButtonText.tr,
        onPrimaryPressed: () {
          Get.back();
          tmtTestNewFlowController.advanceState();
        },
      ),
    );
  }

  void _showPracticeCompletedBDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        mode: DialogMode.singleButton,
        title: TMTGamePracticesText.tmtGamePracticeCompletedBDialogTitle.tr,
        content: TMTGamePracticesText.tmtGamePracticeCompletedBDialogContent.tr,
        primaryButtonText:
            TMTGamePracticesText.tmtGamePracticeCompletedBDialogButtonText.tr,
        onPrimaryPressed: () {
          Get.back();
          tmtTestNewFlowController.advanceState();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? AppColors.testTMTBoardBackgroundDark
          : AppColors.testTMTBoardBackground,
      appBar: CustomAppBar(
        title: _getHelpTitle(tmtTestPracticeMode),
      ),
      body: _boardController ?? Container(),
    );
  }

  String _getHelpTitle(TMTTestPracticeMode practiceMode) {
    switch (practiceMode) {
      case TMTTestPracticeMode.TMT_A_ONLY:
        return TMTGamePracticesText.tmtGamePracticeTmtAPageTitle.tr;
      case TMTTestPracticeMode.TMT_B_ONLY:
        return TMTGamePracticesText.tmtGamePracticeTmtBPageTitle.tr;
    }
  }
}
