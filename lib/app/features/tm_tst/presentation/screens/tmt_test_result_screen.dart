import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/AppColors.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../../../utils/services/app_logger.dart';
import '../../../../utils/services/request_state.dart';
import '../../domain/usecases/tmt_result_screen_responsive_calculator.dart';
import '../components/tmt_result_card.dart';
import '../controllers/tmt_result_controller.dart';
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

  static const String _loggerTag = 'TmtResultsScreen';

  Worker? _stateWorker;

  double _cardsToTextMargin = 0;
  double _textToButtonMargin = 0;

  late TmtTestFlowStateController _testController;
  late TmtResultController _resultController;

  int _timeCompleteA = 0;
  int _timeCompleteB = 0;
  int _errorsA = 0;
  int _errorsB = 0;
  int _numSessions = 0;

  bool _resultsSent = false;

  @override
  void initState() {
    super.initState();
    _testController = Get.find<TmtTestFlowStateController>();
    _resultController = Get.find<TmtResultController>();

    _loadTestResults();
    _setupStateObserver();
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
    _stateWorker = ever(_resultController.state, (state) {
      if (state is RequestInitial) {
      } else if (state is RequestLoading) {
      } else if (state is RequestSuccess) {
      } else if (state is RequestError) {}
    });
  }

  void _loadTestResults() {
    final metrics = _testController.metricsController;

    _timeCompleteA =
        metrics.testTimeMetrics.calculateTimeCompleteTmtA().inSeconds;
    _timeCompleteB =
        metrics.testTimeMetrics.calculateTimeCompleteTmtB().inSeconds;
    _errorsA = metrics.numberErrorA;
    _errorsB = metrics.numberErrorB;

    _numSessions = 1; //TODO get number of sessions from local storage
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
    _stateWorker?.dispose();
    super.dispose();
  }

  void _calculateCardHeight() {
    final RenderBox? cardBox =
        _cardKey.currentContext?.findRenderObject() as RenderBox?;
    if (cardBox != null) {
      final height = cardBox.size.height;

      final proportions =
          TmtResultResponsiveCalculator.calculateCardHeightProportions(height);

      setState(() {
        _cardsToTextMargin = proportions.cardsToTextMargin;
        _textToButtonMargin = proportions.textToButtonMargin;
      });
    }
  }

  void _calculateContentHeight() {
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

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (_resultController.isLoading) {
            return _buildLoadingScreen();
          } else {
            return _buildResultContent(context);
          }
        }),
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

  Widget _buildResultContent(BuildContext context) {
    final metrics =
        TmtResultResponsiveCalculator.calculateLayoutMetrics(context);
    final useProportionalMargins = metrics.isTablet || !metrics.isLandscape;

    return Stack(
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
              padding:
                  EdgeInsets.symmetric(horizontal: metrics.horizontalPadding),
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
                  Center(
                    child: Text(
                      '${TMTResultScreen.sessionText.tr} $_numSessions',
                      style: TextStyleBase.h2,
                    ),
                  ),
                  SizedBox(height: metrics.sessionsToCardMargin),
                  SizedBox(
                    width: metrics.cardContainerWidth,
                    child: metrics.isLandscape
                        ? _buildLandscapeCards()
                        : _buildPortraitCards(),
                  ),
                  SizedBox(
                      height: useProportionalMargins && _cardsToTextMargin > 0
                          ? _cardsToTextMargin
                          : metrics.cardsToThanksTextMargin),
                  Text(
                    TMTResultScreen.thanksMessage.tr,
                    style: AppTextStyle.tmtResultThanksText,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                      height: useProportionalMargins && _textToButtonMargin > 0
                          ? _textToButtonMargin
                          : metrics.tanksTextToButtonMargin),
                  CustomPrimaryButton(
                    text: TMTResultScreen.finishButton.tr,
                    onPressed: () {
                      Get.offAllNamed(Routes.home);
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
    );
  }

  Widget _buildLandscapeCards() {
    final metrics =
        TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

    return Row(
      children: [
        Expanded(
          child: TmtResultCard(
            key: _cardKey,
            title: TMTResultScreen.tmtATitle.tr,
            duration: '$_timeCompleteA S',
            errors: _errorsA.toString(),
          ),
        ),
        SizedBox(width: metrics.horizontalCardSpacing),
        Expanded(
          child: TmtResultCard(
            title: TMTResultScreen.tmtBTitle.tr,
            duration: '$_timeCompleteB S',
            errors: _errorsB.toString(),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitCards() {
    final metrics =
        TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

    return Column(
      children: [
        TmtResultCard(
          key: _cardKey,
          title: TMTResultScreen.tmtATitle.tr,
          duration: '$_timeCompleteA S',
          errors: _errorsA.toString(),
        ),
        SizedBox(height: metrics.betweenCardsMargin),
        TmtResultCard(
          title: TMTResultScreen.tmtBTitle.tr,
          duration: '$_timeCompleteB S',
          errors: _errorsB.toString(),
        ),
      ],
    );
  }

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
                    Colors.white.withValues(alpha: 0),
                    Colors.white.withAlpha(204)
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
                  color: Colors.white.withAlpha(0),
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
