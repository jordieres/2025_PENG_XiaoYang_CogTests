import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_game_board_controller.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/controllers/tmt_test_controller.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_dialog.dart';

class TmtTestPage extends StatefulWidget {
  const TmtTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TmtTestPageState();
  }
}

class _TmtTestPageState extends State<TmtTestPage> {
  TmtGameBoardController? _boardController;
  late TmtTestController _testController;
  Worker? _stateWorker;

  @override
  void initState() {
    super.initState();
    _testController = Get.find<TmtTestController>();

    _stateWorker = ever(_testController.testState, (state) {
      if (state == TmtTestStateFlow.TMT_A_COMPLETED) {
        if (mounted) {
          _showPartACompletedDialog();
        }
      } else if (state == TmtTestStateFlow.TEST_COMPLETED) {
        Get.offNamed(Routes.tmt_results);
      }
    });
  }

  @override
  void dispose() {
    _stateWorker?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _boardController = TmtGameBoardController(
        key: ValueKey(_testController.testState.value.toString()));
  }

  bool _isTestTypeA() {
    bool isA =
        _testController.testState.value == TmtTestStateFlow.TMT_A_IN_PROGRESS ||
            _testController.testState.value == TmtTestStateFlow.READY;
    return isA;
  }

  String _getAppBarTitle() {
    return _isTestTypeA() ? 'TMT Test - Part A' : 'TMT Test - Part B';
  }

  void _showPartACompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDialog(
        mode: DialogMode.singleButton,
        title: TMTGame.tmtGamePartACompletedBody.tr,
        primaryButtonText: TMTGame.tmtGamePartBCompletedConfirmationButton.tr,
        onPrimaryPressed: () {
          setState(() {
            _boardController = TmtGameBoardController(
                key: ValueKey(_testController.testState.value.toString()));
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.testTMTBoardBackground,
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
      ),
      body: _boardController ?? Container(),
    );
  }
}
