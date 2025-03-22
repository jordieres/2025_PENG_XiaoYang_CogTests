import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_game_board_controller.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/controllers/tmt_test_flow_state_controller.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/routes/app_route_observer.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../components/tmt_test_app_bar.dart';
import '../controllers/base_tmt_test_flow_contoller.dart';

class TmtTestPage extends StatefulWidget {
  const TmtTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TmtTestPageState();
  }
}

class _TmtTestPageState extends State<TmtTestPage> with WidgetsBindingObserver {
  TmtGameBoardController? _boardController;
  late TmtTestFlowStateController _testTmtFlowStateController;
  Worker? _stateWorker;
  Worker? _routeObserverWorker;

  final TmtAppBarController _timerController = TmtAppBarController();

  @override
  void initState() {
    super.initState();
    _testTmtFlowStateController = Get.find<TmtTestFlowStateController>();
    _tmtTestFlowStateObserver();
    _tmtTestRouteChangeObserver();
    WidgetsBinding.instance.addObserver(this);
  }

  void _tmtTestFlowStateObserver() {
    _stateWorker = ever(_testTmtFlowStateController.testState, (state) {
      if (!mounted) return;

      if (state == TmtTestStateFlow.TMT_A_COMPLETED) {
        _pauseTimer();
        if (mounted) {
          _showPartACompletedDialog();
        }
      } else if (state == TmtTestStateFlow.TEST_COMPLETED) {
        _pauseTimer();
        Get.offNamed(Routes.tmt_results);
      }
    });
  }

  void _tmtTestRouteChangeObserver() {
    _routeObserverWorker = ever(appRouteObserver.currentRouteName, (routeName) {
      if (routeName == Routes.tmt_test) {
        final currentTestState = _testTmtFlowStateController.testState.value;
        if (currentTestState == TmtTestStateFlow.TMT_A_IN_PROGRESS ||
            currentTestState == TmtTestStateFlow.READY) {
          _resetTmtA();
        } else if (currentTestState == TmtTestStateFlow.TMT_B_IN_PROGRESS) {
          _resetTmtB();
        }
      } else {
        _pauseTimer();
      }
    });
  }

  @override
  void didChangeMetrics() {
    // When change screen orientation
    setState(() {
      final currentStatus= _testTmtFlowStateController.testState.value;
      if (currentStatus == TmtTestStateFlow.TMT_A_IN_PROGRESS ||
          currentStatus == TmtTestStateFlow.READY) {
        _resetTmtA();
      } else if (currentStatus == TmtTestStateFlow.TMT_B_IN_PROGRESS) {
        _resetTmtB();
      }
    });
  }

  void _resetTmtA() {
    _testTmtFlowStateController.resetStatusTmtA();
    setState(() {
      _boardController = TmtGameBoardController(
          key: UniqueKey(), flowController: _testTmtFlowStateController);
      _resetTimer();
    });
  }

  void _resetTmtB() {
    _testTmtFlowStateController.resetStatusTmtB();
    setState(() {
      _boardController = TmtGameBoardController(
          key: UniqueKey(), flowController: _testTmtFlowStateController);
      _setStartTime(_testTmtFlowStateController.getTmtATimeInSec());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stateWorker?.dispose();
    _routeObserverWorker?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _boardController = TmtGameBoardController(
        key: UniqueKey(), flowController: _testTmtFlowStateController);
  }

  bool _isTestTypeA() {
    bool isA = _testTmtFlowStateController.testState.value ==
            TmtTestStateFlow.TMT_A_IN_PROGRESS ||
        _testTmtFlowStateController.testState.value == TmtTestStateFlow.READY;
    return isA;
  }

  String _getAppBarTitle() {
    return _isTestTypeA() ? 'TMT A' : 'TMT B';
  }

  void _pauseTimer() {
    _timerController.pauseTimer?.call();
  }

  void _resumeTimer() {
    _timerController.resumeTimer?.call();
  }

  void _resetTimer() {
    _timerController.resetTimer?.call();
  }

  void _setStartTime(int initialSeconds) {
    _timerController.setStartTime?.call(initialSeconds);
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
          Get.back();
          setState(() {
            _boardController = TmtGameBoardController(
                key: UniqueKey(), flowController: _testTmtFlowStateController);
            _resumeTimer();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.testTMTBoardBackground,
      appBar: TmtCustomAppBar(
        title: _getAppBarTitle(),
        isTestTypeA: _isTestTypeA(),
        controller: _timerController,
      ),
      body: _boardController ?? Container(),
    );
  }
}
