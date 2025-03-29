import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../../../utils/services/app_logger.dart';
import '../../../../utils/services/request_state.dart';
import '../../domain/entities/tmt_game_result_data.dart';
import '../../domain/entities/tmt_user_data.dart';
import '../../domain/usecases/tmt_result_screen_responsive_calculator.dart';
import '../components/tmt_result_card.dart';
import '../controllers/TmtResultController.dart';
import '../controllers/tmt_test_flow_state_controller.dart';

class TmtResultsScreen extends StatefulWidget {
  const TmtResultsScreen({super.key});

  @override
  State<TmtResultsScreen> createState() => _TmtResultsScreenState();
}

class _TmtResultsScreenState extends State<TmtResultsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = false;
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _cardKey = GlobalKey();
  DateTime? _lastCalculation;

  // Logger tag
  static const String _loggerTag = 'TmtResultsScreen';

  Worker? _stateWorker;

  // Margin values based on card height
  double _cardsToTextMargin = 0;
  double _textToButtonMargin = 0;

  // Result data from test controller
  late TmtTestFlowStateController _testController;
  late TmtResultController _resultController;

  // Actual test results
  int timeCompleteA = 0;
  int timeCompleteB = 0;
  int errorsA = 0;
  int errorsB = 0;
  int numSessions = 0;

  // Track if results were sent
  bool _resultsSent = false;

  @override
  void initState() {
    super.initState();
    _testController = Get.find<TmtTestFlowStateController>();
    _resultController = Get.find<TmtResultController>();

    // Load result values
    _loadTestResults();

    // Set up worker to observe state changes
    _setupStateObserver();

    // Send results once
    _sendResults();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateContentHeight();
      _calculateCardHeight();
    });

    _scrollController.addListener(() {
      _updateScrollIndicator();
    });
  }

  void _setupStateObserver() {
    // Use ever to watch for state changes in the result controller
    _stateWorker = ever(_resultController.state, (state) {
      if (state is RequestInitial) {
        AppLogger.debug(
            _loggerTag, 'State changed to: RequestInitial - Starting request');
      } else if (state is RequestLoading) {
        AppLogger.debug(_loggerTag,
            'State changed to: RequestLoading - Request in progress');
      } else if (state is RequestSuccess) {
        AppLogger.debug(_loggerTag,
            'State changed to: RequestSuccess - Request completed successfully');
        AppLogger.debug(_loggerTag, 'Data received: ${state.data}');
      } else if (state is RequestError) {
        AppLogger.debug(
            _loggerTag, 'State changed to: RequestError - Request failed');
        AppLogger.debug(_loggerTag, 'Error message: ${state.message}');
        AppLogger.debug(_loggerTag, 'Status code: ${state.statusCode}');

        if (state.isNetworkError) {
          AppLogger.debug(_loggerTag, 'Network error detected');
        } else if (state.isServerError) {
          AppLogger.debug(_loggerTag, 'Server error detected');
        } else if (state.isClientError) {
          AppLogger.debug(_loggerTag, 'Client error detected');
        } else if (state.isAuthError) {
          AppLogger.debug(_loggerTag, 'Authentication error detected');
        }
      }
    });
  }

  void _loadTestResults() {
    // Get metrics from test controller
    final metrics = _testController.metricsController;

    // Set values for UI display
    timeCompleteA =
        metrics.testTimeMetrics.calculateTimeCompleteTmtA().inSeconds;
    timeCompleteB =
        metrics.testTimeMetrics.calculateTimeCompleteTmtB().inSeconds;
    errorsA = metrics.numberErrorA;
    errorsB = metrics.numberErrorB;

    // If you have a way to get session count, set it here
    numSessions = 1; // Default to 1 if not available
  }

  Future<void> _sendResults() async {
    if (_resultsSent) return;
    try {
      await _resultController.reportResults(_testController.metricsController);
      _resultsSent = true;
    } catch (e) {
      AppLogger.severe(_loggerTag, "Error sending results", e);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateContentHeight();
      _calculateCardHeight();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _stateWorker?.dispose(); // Cleanup the worker when the screen is disposed
    super.dispose();
  }

  void _calculateCardHeight() {
    final RenderBox? cardBox =
        _cardKey.currentContext?.findRenderObject() as RenderBox?;
    if (cardBox != null) {
      final height = cardBox.size.height;

      // Use the calculator to get proportions based on height
      final proportions =
          TmtResultResponsiveCalculator.calculateCardHeightProportions(height);

      setState(() {
        _cardsToTextMargin = proportions.cardsToTextMargin;
        _textToButtonMargin = proportions.textToButtonMargin;
      });
    }
  }

  void _calculateContentHeight() {
    // Debounce calculations to prevent too frequent recalculations
    final now = DateTime.now();
    if (_lastCalculation != null &&
        now.difference(_lastCalculation!).inMilliseconds < 300) {
      return;
    }
    _lastCalculation = now;

    final RenderBox? contentBox =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (contentBox != null) {
      final screenHeight = MediaQuery.of(context).size.height;

      setState(() {
        _showScrollIndicator =
            TmtResultResponsiveCalculator.shouldShowScrollIndicator(
          contentBox: contentBox,
          screenHeight: screenHeight,
        );
      });
    }
  }

  void _updateScrollIndicator() {
    if (_scrollController.hasClients) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 20) {
        if (_showScrollIndicator) {
          setState(() {
            _showScrollIndicator = false;
          });
        }
      } else {
        _calculateContentHeight();
      }
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
  Widget build(BuildContext context) {
    DeviceHelper.calculateAgain(context);

    // Use the calculator to get layout metrics
    final metrics =
        TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

    // Determine whether to use fixed or proportional values based on card height
    final useProportionalMargins = metrics.isTablet || !metrics.isLandscape;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Container(
                  key: _contentKey,
                  constraints: BoxConstraints(
                    maxWidth: metrics.contentMaxWidth,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: metrics.horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: metrics.topMargin),
                      Center(
                        child: Text(
                          TMTResultScreen.title.tr,
                          style: TextStyleBase.h1,
                        ),
                      ),
                      SizedBox(height: metrics.titleToSessionsMargin),
                      // New element: Number of Sessions
                      Center(
                        child: Text(
                          '${TMTResultScreen.sessionText.tr} $numSessions',
                          style: TextStyleBase.h2,
                        ),
                      ),
                      SizedBox(height: metrics.sessionsToCardMargin),
                      // Container for cards with limited width on tablets
                      SizedBox(
                        width: metrics.cardContainerWidth,
                        child: metrics.isLandscape
                            ? _buildLandscapeCards()
                            : _buildPortraitCards(),
                      ),
                      // Use the calculated margin if applicable, or the fixed one otherwise
                      SizedBox(
                          height:
                              useProportionalMargins && _cardsToTextMargin > 0
                                  ? _cardsToTextMargin
                                  : metrics.cardsToThanksTextMargin),
                      Text(
                        TMTResultScreen.thanksMessage.tr,
                        style: TextStyleBase.bodyS,
                        textAlign: TextAlign.center,
                      ),
                      // Use the calculated margin if applicable, or the fixed one otherwise
                      SizedBox(
                          height:
                              useProportionalMargins && _textToButtonMargin > 0
                                  ? _textToButtonMargin
                                  : metrics.tanksTextToButtonMargin),
                      // Status indicator for result submission
                      Obx(() => _buildStatusIndicator()),
                      SizedBox(height: 20),
                      CustomPrimaryButton(
                        text: TMTResultScreen.finishButton.tr,
                        onPressed: () {
                          // Get.offAllNamed(Routes.home);
                        },
                      ),
                      SizedBox(height: metrics.bottomMargin),
                    ],
                  ),
                ),
              ),
            ),
            if (_showScrollIndicator) _buildScrollIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    if (_resultController.isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2)),
          SizedBox(width: 10),
          Text("Sending results...", style: TextStyleBase.bodyS),
        ],
      );
    } else if (_resultController.isSuccess) {
      return Text(
        "Results successfully sent",
        style: TextStyleBase.bodyS.copyWith(color: Colors.green),
      );
    } else if (_resultController.hasError) {
      return Text(
        "Error: ${_resultController.errorMessage}",
        style: TextStyleBase.bodyS.copyWith(color: Colors.red),
      );
    }
    return SizedBox();
  }

  /// Builds card layout for horizontal mode
  Widget _buildLandscapeCards() {
    final metrics =
        TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

    return Row(
      children: [
        Expanded(
          child: TmtResultCard(
            key: _cardKey,
            title: TMTResultScreen.tmtATitle.tr,
            duration: '$timeCompleteA S',
            errors: errorsA.toString(),
          ),
        ),
        SizedBox(width: metrics.horizontalCardSpacing),
        Expanded(
          child: TmtResultCard(
            title: TMTResultScreen.tmtBTitle.tr,
            duration: '$timeCompleteB S',
            errors: errorsB.toString(),
          ),
        ),
      ],
    );
  }

  /// Builds card layout for vertical mode
  Widget _buildPortraitCards() {
    final metrics =
        TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

    return Column(
      children: [
        TmtResultCard(
          key: _cardKey,
          title: TMTResultScreen.tmtATitle.tr,
          duration: '$timeCompleteA S',
          errors: errorsA.toString(),
        ),
        SizedBox(height: metrics.betweenCardsMargin),
        TmtResultCard(
          title: TMTResultScreen.tmtBTitle.tr,
          duration: '$timeCompleteB S',
          errors: errorsB.toString(),
        ),
      ],
    );
  }

  /// Builds the scroll indicator
  Widget _buildScrollIndicator() {
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
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.8)
                  ],
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
                  color: Colors.white.withOpacity(0),
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
