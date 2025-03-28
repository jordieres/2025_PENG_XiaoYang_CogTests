import 'package:flutter/material.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../domain/usecases/tmt_result_screen_responsive_calculator.dart';
import '../components/tmt_result_card.dart';

// Added for testing
void main() {
  runApp(
    MaterialApp(
      home: TmtResultsScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}

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

  // Margin values based on card height
  double _cardsToTextMargin = 0;
  double _textToButtonMargin = 0;

  // Mock data for UI testing
  final int timeCompleteA = 30;
  final int timeCompleteB = 30;
  final int errorsA = 1;
  final int errorsB = 1;
  final int numSessions = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateContentHeight();
      _calculateCardHeight();
    });

    _scrollController.addListener(() {
      _updateScrollIndicator();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This will be called when MediaQuery changes, including orientation changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateContentHeight();
      _calculateCardHeight();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
        _showScrollIndicator = TmtResultResponsiveCalculator.shouldShowScrollIndicator(
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
    final metrics = TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

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
                          'Resultado:',
                          style: TextStyleBase.h1,
                        ),
                      ),
                      SizedBox(height: metrics.titleToSessionsMargin),
                      // New element: Number of Sessions
                      Center(
                        child: Text(
                          'Número de Sesiones $numSessions',
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
                        'Le agradecemos la confianza, el tiempo y el esfuerzo\nen realizar este test dTMT',
                        style: TextStyleBase.bodyS,
                        textAlign: TextAlign.center,
                      ),
                      // Use the calculated margin if applicable, or the fixed one otherwise
                      SizedBox(
                          height:
                          useProportionalMargins && _textToButtonMargin > 0
                              ? _textToButtonMargin
                              : metrics.tanksTextToButtonMargin),
                      CustomPrimaryButton(
                        text: 'Terminar',
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

  /// Builds card layout for horizontal mode
  Widget _buildLandscapeCards() {
    final metrics = TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

    return Row(
      children: [
        Expanded(
          child: TmtResultCard(
            key: _cardKey,
            title: 'TMT A',
            duration: '$timeCompleteA S',
            errors: errorsA.toString(),
          ),
        ),
        SizedBox(width: metrics.horizontalCardSpacing),
        Expanded(
          child: TmtResultCard(
            title: 'TMT B',
            duration: '$timeCompleteB S',
            errors: errorsB.toString(),
          ),
        ),
      ],
    );
  }

  /// Builds card layout for vertical mode
  Widget _buildPortraitCards() {
    final metrics = TmtResultResponsiveCalculator.calculateLayoutMetrics(context);

    return Column(
      children: [
        TmtResultCard(
          key: _cardKey,
          title: 'TMT A',
          duration: '$timeCompleteA S',
          errors: errorsA.toString(),
        ),
        SizedBox(height: metrics.betweenCardsMargin),
        TmtResultCard(
          title: 'TMT B',
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