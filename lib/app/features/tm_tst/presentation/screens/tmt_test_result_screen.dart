import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/user/presentation/contoller/test_result_controller.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../../../utils/services/app_logger.dart';
import '../../../../utils/services/request_state.dart';
import '../../../../utils/ui/ui_utils.dart';
import '../../../user/domain/entities/user_test_local_data_result.dart';
import '../../domain/entities/result/tmt_game_init_data.dart';
import '../../domain/usecases/tmt_result/tmt_result_screen_responsive_calculator.dart';
import '../components/tmt_result_card.dart';
import '../controllers/tmt_result_report_controller.dart';
import '../newscreens/tmt_test_navigation_flow.dart';

class TmtResultsScreen extends StatefulWidget {
  const TmtResultsScreen({super.key});

  @override
  State<TmtResultsScreen> createState() => _TmtResultsScreenState();
}

class _TmtResultsScreenState extends State<TmtResultsScreen>
    with NavigationMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = false;
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _cardKey = GlobalKey();
  bool _isLoadingTestResults = true;

  static const String _loggerTag = 'TmtResultsScreen';

  Worker? _stateWorker;

  late ResultLayoutMetrics _metrics;

  late TmtTestNavigationFlowController _tmtTestNavigationFlowController;
  late TmtResultReportController _resultController;
  late TestResultLocalDataController _testResultLocalDataController;

  late TmtGameInitData tmtGameInitData;

  int _timeCompleteA = 0;
  int _timeCompleteB = 0;
  int _errorsA = 0;
  int _errorsB = 0;
  int _numSessions = 0;

  bool _resultsSent = false;
  Orientation _lastOrientation = Orientation.portrait;

  @override
  void initState() {
    super.initState();
    _tmtTestNavigationFlowController =
        Get.find<TmtTestNavigationFlowController>();
    _resultController = Get.find<TmtResultReportController>();
    _testResultLocalDataController = Get.find<TestResultLocalDataController>();

    _lastOrientation = MediaQuery.of(Get.context!).orientation;
    _metrics =
        TmtResultResponsiveCalculator.calculateLayoutMetrics(Get.context!);

    _loadTestResults();
    _setupStateObserver();
    _sendResults();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollStatus();
    });

    _scrollController.addListener(_onScroll);
  }

  void _setupStateObserver() {
    _stateWorker = ever(_resultController.state, (state) {
      if (state is RequestInitial) {
      } else if (state is RequestLoading) {
      } else if (state is RequestSuccess) {
        _saveTestResultToLocal();
      } else if (state is RequestError) {
        _showErrorSnackBar(state.message);
      }
    });
  }

  void _saveTestResultToLocal() {
    final metrics = _tmtTestNavigationFlowController.metricsController;

    _testResultLocalDataController.saveTestResult(UserTestLocalDataResult(
      referenceCode: tmtGameInitData.tmtGameCodeId,
      date: DateTime.now(),
      tmtATime: metrics.testTimeMetrics.calculateTimeCompleteTmtA(),
      tmtBTime: metrics.testTimeMetrics.calculateTimeCompleteTmtB(),
      handUsed: tmtGameInitData.tmtGameHandUsed.value,
    ));
  }

  void _showErrorSnackBar(String? message) {
    AppSnackbar.showCustomSnackbar(
      context,
      TMTResultScreen.errorMessage.tr,
    );
  }

  Future<void> _loadNumberOfSessions() async {
    _isLoadingTestResults = true;
    await _testResultLocalDataController.loadCurrentUserTestResults();

    if (mounted) {
      setState(() {
        _numSessions = _testResultLocalDataController.testResults.length + 1;
        _isLoadingTestResults = false;
      });
    }
  }

  void _loadTestResults() {
    final metrics = _tmtTestNavigationFlowController.metricsController;

    _timeCompleteA =
        metrics.testTimeMetrics.calculateTimeCompleteTmtA().round();
    _timeCompleteB =
        metrics.testTimeMetrics.calculateTimeCompleteTmtB().round();
    _errorsA = metrics.numberErrorA;
    _errorsB = metrics.numberErrorB;

    _numSessions = 1;
    _isLoadingTestResults = true;
    _loadNumberOfSessions();
  }

  Future<void> _sendResults() async {
    if (_resultsSent) return;
    try {
      tmtGameInitData = Get.arguments as TmtGameInitData;
      await _resultController.reportResults(
          _tmtTestNavigationFlowController.metricsController, tmtGameInitData);
      _resultsSent = true;
    } catch (e) {
      AppLogger.severe(_loggerTag, "Error sending results", e);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentOrientation = MediaQuery.of(context).orientation;
    if (currentOrientation != _lastOrientation) {
      _lastOrientation = currentOrientation;

      _metrics = TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }

      setState(() {
        _showScrollIndicator = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 100), _checkScrollStatus);
      });
    }
  }

  void _checkScrollStatus() {
    if (!mounted || !_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 50), _checkScrollStatus);
      return;
    }

    final hasScrollContent = _scrollController.position.maxScrollExtent > 0;
    if (_showScrollIndicator != hasScrollContent) {
      setState(() {
        _showScrollIndicator = hasScrollContent;
      });
    }
  }

  void _onScroll() {
    if (!mounted || !_scrollController.hasClients) return;

    final isNearBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 20;

    if (isNearBottom && _showScrollIndicator) {
      setState(() {
        _showScrollIndicator = false;
      });
    } else if (!isNearBottom &&
        !_showScrollIndicator &&
        _scrollController.position.maxScrollExtent > 0) {
      setState(() {
        _showScrollIndicator = true;
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _stateWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceHelper.calculateAgain(context);
    _metrics = TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          navigateAllToHome();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(() {
            if (_resultController.isLoading || _isLoadingTestResults) {
              return _buildLoadingScreen();
            } else {
              return _buildResultContent();
            }
          }),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            TMTResultScreen.loadingResults.tr,
            style: TextStyleBase.bodyL,
          ),
        ],
      ),
    );
  }

  Widget _buildResultContent() {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Container(
              key: _contentKey,
              constraints: BoxConstraints(
                maxWidth: _metrics.contentMaxWidth,
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: _metrics.horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: _metrics.topMargin),
                  Center(
                    child: Text(
                      TMTResultScreen.title.tr,
                      style: TextStyleBase.h1,
                    ),
                  ),
                  SizedBox(height: _metrics.titleToSessionsMargin),
                  Center(
                    child: Text(
                      '${TMTResultScreen.sessionText.tr} $_numSessions',
                      style: TextStyleBase.h2,
                    ),
                  ),
                  SizedBox(height: _metrics.sessionsToCardMargin),
                  SizedBox(
                    width: _metrics.cardContainerWidth,
                    child: _metrics.isLandscape
                        ? _buildLandscapeCards()
                        : _buildPortraitCards(),
                  ),
                  SizedBox(height: _metrics.cardsToThanksTextMargin),
                  Text(
                    TMTResultScreen.thanksMessage.tr,
                    style: AppTextStyle.tmtResultThanksText,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: _metrics.tanksTextToButtonMargin),
                  CustomPrimaryButton(
                    text: TMTResultScreen.finishButton.tr,
                    onPressed: () {
                      navigateAllToHome();
                    },
                  ),
                  SizedBox(height: _metrics.bottomMargin),
                ],
              ),
            ),
          ),
        ),
        if (_showScrollIndicator) _buildScrollIndicator(),
      ],
    );
  }

  Widget _buildLandscapeCards() {
    return Row(
      children: [
        Expanded(
          child: TmtResultCard(
            key: _cardKey,
            title: TMTResultScreen.tmtATitle.tr,
            duration: '$_timeCompleteA ${TMTResultScreen.secondsUnit.tr}',
            errors: _errorsA.toString(),
          ),
        ),
        SizedBox(width: _metrics.horizontalCardSpacing),
        Expanded(
          child: TmtResultCard(
            title: TMTResultScreen.tmtBTitle.tr,
            duration: '$_timeCompleteB ${TMTResultScreen.secondsUnit.tr}',
            errors: _errorsB.toString(),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitCards() {
    return Column(
      children: [
        TmtResultCard(
          key: _cardKey,
          title: TMTResultScreen.tmtATitle.tr,
          duration: '$_timeCompleteA ${TMTResultScreen.secondsUnit.tr}',
          errors: _errorsA.toString(),
        ),
        SizedBox(height: _metrics.betweenCardsMargin),
        TmtResultCard(
          title: TMTResultScreen.tmtBTitle.tr,
          duration: '$_timeCompleteB ${TMTResultScreen.secondsUnit.tr}',
          errors: _errorsB.toString(),
        ),
      ],
    );
  }

  Widget _buildScrollIndicator() {
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [bgColor.withAlpha(0), bgColor.withAlpha(204)],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Center(
            child: GestureDetector(
              onTap: _scrollToBottom,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
