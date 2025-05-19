import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_count_down_component.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/components/tmt_game_board_controller.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/controllers/tmt_test_flow_state_controller.dart';
import 'package:msdtmt/app/utils/ui/ui_utils.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/routes/app_route_observer.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../components/tmt_test_app_bar.dart';
import '../controllers/base_tmt_test_flow_contoller.dart';
import '../newscreens/tmt_test_navigation_flow.dart';

enum TmtType { tmtA, tmtB }

class TmtTestPage extends StatefulWidget {
  const TmtTestPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TmtTestPageState();
  }
}

class _TmtTestPageState extends State<TmtTestPage>
    with WidgetsBindingObserver, NavigationMixin {
  late TmtTestNavigationFlowController tmtTestNewFlowController;
  TmtGameBoardController? _boardController;
  late TmtTestFlowStateController _testTmtFlowStateController;
  TmtType? _tmtType;
  Worker? _stateWorker;
  Worker? _routeObserverWorker;

  bool _isCountdownActive = true;
  bool _isResettingTmtA = false;
  bool _isResettingTmtB = false;

  final TmtAppBarController _timerController = TmtAppBarController();

  @override
  void initState() {
    super.initState();
    _testTmtFlowStateController = Get.find<TmtTestFlowStateController>();
    tmtTestNewFlowController = Get.find<TmtTestNavigationFlowController>();
    _getArgument();
    _tmtTestFlowStateObserver();
    _tmtTestRouteChangeObserver();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pauseTimer();
    });
  }

  void _getArgument() {
    try {
      _tmtType = Get.arguments as TmtType?;
      if (_tmtType == TmtType.tmtB) {
        _testTmtFlowStateController.testState.value =
            TmtTestStateFlow.TMT_B_IN_PROGRESS;
      }
    } catch (e) {
      AppSnackbar.showCustomSnackbar(context, "Error argument");
      navigateToHome();
    }
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
        tmtTestNewFlowController.advanceState();
      }
    });
  }

  void _tmtTestRouteChangeObserver() {
    _routeObserverWorker = ever(appRouteObserver.currentRouteName, (routeName) {
      if (routeName == Routes.tmt_test) {
        if (!_isCountdownActive) {
          final currentTestState = _testTmtFlowStateController.testState.value;
          if (currentTestState == TmtTestStateFlow.TMT_A_IN_PROGRESS ||
              currentTestState == TmtTestStateFlow.READY) {
            _resetTmtA();
          } else if (currentTestState == TmtTestStateFlow.TMT_B_IN_PROGRESS) {
            _resetTmtB();
          }
        }
      } else {
        _pauseTimer();
      }
    });
  }

  @override
  void didChangeMetrics() {
    // When change screen orientation
    if (!_isCountdownActive) {
      setState(() {
        final currentStatus = _testTmtFlowStateController.testState.value;
        if (currentStatus == TmtTestStateFlow.TMT_A_IN_PROGRESS ||
            currentStatus == TmtTestStateFlow.READY) {
          _resetTmtA();
        } else if (currentStatus == TmtTestStateFlow.TMT_B_IN_PROGRESS) {
          _resetTmtB();
        }
      });
    }
  }

  void _resetTmtA() {
    _testTmtFlowStateController.resetStatusTmtA();
    _testTmtFlowStateController.initializeGameConfig().then((bool isLoaded) {
      setState(() {
        _isCountdownActive = true;
        _isResettingTmtA = true;
      });
    });
  }

  void _resetTmtB() {
    _testTmtFlowStateController.resetStatusTmtB();
    _testTmtFlowStateController.initializeGameConfig().then((bool isLoaded) {
      setState(() {
        _isCountdownActive = true;
        _isResettingTmtB = true;
      });
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

    if (!_isCountdownActive) {
      _boardController = TmtGameBoardController(
          key: UniqueKey(), flowController: _testTmtFlowStateController);
    }
  }

  void _onCountdownComplete() {
    setState(() {
      _isCountdownActive = false;
      _boardController = TmtGameBoardController(
          key: UniqueKey(), flowController: _testTmtFlowStateController);
      _resumeTimer();
      _resetFlags();
    });
  }

  void _resetFlags() {
    _isResettingTmtA = false;
    _isResettingTmtB = false;
  }

  bool _isTestTypeA() {
    bool isA = _tmtType == TmtType.tmtA;
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
        title: TMTGameText.tmtGamePartACompletedBody.tr,
        primaryButtonText:
            TMTGameText.tmtGamePartBCompletedConfirmationButton.tr,
        onPrimaryPressed: () {
          Get.back();
          tmtTestNewFlowController.advanceState();
        },
      ),
    );
  }

  bool get isDarkMode => Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.testTMTBoardBackgroundDark
          : AppColors.testTMTBoardBackground,
      appBar: TmtCustomAppBar(
        title: _getAppBarTitle(),
        isTestTypeA: _isTestTypeA(),
        controller: _timerController,
        initialSeconds: _tmtType == TmtType.tmtB
            ? _testTmtFlowStateController.getTmtATimeInSec()
            : 0,
      ),
      body: _isCountdownActive
          ? _createCountdownComponent()
          : _boardController ?? Container(),
    );
  }

  Widget _createCountdownComponent() {
    if (_isResettingTmtA) {
      _resetTimer();
    } else if (_isResettingTmtB || _tmtType == TmtType.tmtB) {
      _setStartTime(_testTmtFlowStateController.getTmtATimeInSec());
    }
    _pauseTimer();
    return TmtCountdownComponent(
        onCountdownComplete: _onCountdownComplete, testType: _getAppBarTitle());
  }
}
