import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/screens/tmt_test_help.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../components/tmt_game_board_controller.dart';
import '../controllers/base_tmt_test_flow_contoller.dart';
import '../controllers/tmt_practice_flow_state_contoller.dart';

enum TMTTestPracticeMode { TMT_A_ONLY, TMT_B_ONLY, TMT_A_THEN_B }

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
      case TMTTestPracticeMode.TMT_A_THEN_B:
        _practiceController.testState.value = TmtTestStateFlow.READY;
        break;
    }
  }

  void _tmtPracticeFlowStateObserver() {
    _stateWorker = ever(_practiceController.testState, (state) {
      if (!mounted) return;
      if (state == TmtTestStateFlow.TMT_A_COMPLETED) {
        if (tmtTestPracticeMode == TMTTestPracticeMode.TMT_A_THEN_B) {
          if (mounted) {
            _showPartACompletedDialog();
          }
        } else if (tmtTestPracticeMode == TMTTestPracticeMode.TMT_A_ONLY) {
          _showPracticeCompletedDialog();
        }
      } else if (state == TmtTestStateFlow.TEST_COMPLETED) {
        if (tmtTestPracticeMode == TMTTestPracticeMode.TMT_B_ONLY ||
            tmtTestPracticeMode == TMTTestPracticeMode.TMT_A_THEN_B) {
          _showPracticeCompletedDialog();
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

  void _resetTmtA() {
    _practiceController.resetStatusTmtA();
    setState(() {
      _boardController = TmtGameBoardController(
          key: UniqueKey(), flowController: _practiceController);
    });
  }

  void _resetTmtB() {
    _practiceController.resetStatusTmtB();
    setState(() {
      _boardController = TmtGameBoardController(
          key: UniqueKey(), flowController: _practiceController);
    });
  }

  @override
  void dispose() {
    _stateWorker?.dispose();
    super.dispose();
  }

  void _showPartACompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        mode: DialogMode.confirmCancel,
        title: TMTGamePracticesText.tmtGamePracticeTmtAThenBDialogTitle.tr,
        cancelButtonText:
            TMTGamePracticesText.tmtGamePracticeTmtAThenBDialogCancelButtonText.tr,
        primaryButtonText:
            TMTGamePracticesText.tmtGamePracticeTmtAThenBDialogPrimaryButtonText.tr,
        onCancelPressed: () {
          Get.back();
          Get.offNamedUntil(Routes.tmt_help, ModalRoute.withName(Routes.home),
              arguments: TmtHelpMode.TMT_TEST_B);
        },
        onPrimaryPressed: () {
          Get.back();
          _resetTmtA();
        },
      ),
    );
  }

  void _showPracticeCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        mode: DialogMode.confirmCancel,
        title: TMTGamePracticesText.tmtGamePracticeOnlyTmtAOrTmtBDialogTitle.tr,
        cancelButtonText: TMTGamePracticesText
            .tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText.tr,
        primaryButtonText: TMTGamePracticesText
            .tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText.tr,
        onCancelPressed: () {
          Get.back(); //close dialog
          Get.back(); // close practice screen
          Get.back(); // close help screen
        },
        onPrimaryPressed: () {
          Get.back();
          if (tmtTestPracticeMode == TMTTestPracticeMode.TMT_A_ONLY ||
              tmtTestPracticeMode == TMTTestPracticeMode.TMT_A_THEN_B) {
            _resetTmtA();
          } else {
            _resetTmtB();
          }
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
      case TMTTestPracticeMode.TMT_A_THEN_B:
        return TMTGamePracticesText.tmtGamePracticeTmtAPageTitle.tr;
      case TMTTestPracticeMode.TMT_B_ONLY:
        return TMTGamePracticesText.tmtGamePracticeTmtBPageTitle.tr;
    }
  }
}
