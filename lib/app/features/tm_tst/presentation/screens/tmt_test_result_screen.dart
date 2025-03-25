import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../shared_components/custom_primary_button.dart';
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
  DateTime? _lastCalculation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateContentHeight();
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
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateContentHeight() {
    // Debounce calculations to prevent too frequent recalculations
    final now = DateTime.now();
    if (_lastCalculation != null &&
        now.difference(_lastCalculation!).inMilliseconds < 300) {
      return;
    }
    _lastCalculation = now;

    final RenderBox? contentBox = _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (contentBox != null) {
      final contentHeight = contentBox.size.height;
      final screenHeight = MediaQuery.of(context).size.height;

      setState(() {
        _showScrollIndicator = contentHeight > screenHeight;
      });
    }
  }

  void _updateScrollIndicator() {
    if (_scrollController.hasClients) {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 20) {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    const baseScreenHeight = 812.0;
    final responsiveRatio = screenHeight / baseScreenHeight;

    final topMargin = (46 * responsiveRatio).clamp(30.0, 60.0).toDouble();
    final titleToCardMargin = (52 * responsiveRatio).clamp(30.0, 70.0).toDouble();
    final betweenCardsMargin = (46 * responsiveRatio).clamp(30.0, 60.0).toDouble();
    final cardsToTextMargin = isLandscape
        ? (40 * responsiveRatio).clamp(20.0, 60.0).toDouble()
        : (102 * responsiveRatio).clamp(60.0, 120.0).toDouble();

    final textToButtonMargin = (27 * responsiveRatio).clamp(20.0, 40.0).toDouble();
    final bottomMargin = (24 * responsiveRatio).clamp(50.0, 100.0).toDouble();

    final horizontalCardSpacing = (16 * (screenWidth / 375)).clamp(12.0, 30.0).toDouble();

    // Mock data for UI testing
    final int timeCompleteA = 30;
    final int timeCompleteB = 70;
    final int errorsA = 1;
    final int errorsB = 1;
    final String sessions = '3 Veces';

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                key: _contentKey,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: topMargin),
                    Center(
                      child: Text(
                        'Resultado',
                        style: TextStyleBase.h2,
                      ),
                    ),
                    SizedBox(height: titleToCardMargin),

                    if (isLandscape)
                      Row(
                        children: [
                          Expanded(
                            child: TmtResultCard(
                              title: 'TMT A',
                              duration: '$timeCompleteA S',
                              errors: errorsA.toString(),
                              sessions: sessions,
                            ),
                          ),
                          SizedBox(width: horizontalCardSpacing),
                          Expanded(
                            child: TmtResultCard(
                              title: 'TMT B',
                              duration: '$timeCompleteB S',
                              errors: errorsB.toString(),
                              sessions: sessions,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          TmtResultCard(
                            title: 'TMT A',
                            duration: '$timeCompleteA S',
                            errors: errorsA.toString(),
                            sessions: sessions,
                          ),
                          SizedBox(height: betweenCardsMargin),
                          TmtResultCard(
                            title: 'TMT B',
                            duration: '$timeCompleteB S',
                            errors: errorsB.toString(),
                            sessions: sessions,
                          ),
                        ],
                      ),

                    SizedBox(height: cardsToTextMargin),
                    Text(
                      'Le agradecemos la confianza, el tiempo y el esfuerzo\nen realizar este test dTMT',
                      style: TextStyleBase.bodyS,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: textToButtonMargin),

                    CustomPrimaryButton(
                      text: 'Terminar',
                      onPressed: () {
                        Get.offAllNamed(Routes.home);
                      },
                    ),
                    SizedBox(height: bottomMargin),
                  ],
                ),
              ),
            ),

            if (_showScrollIndicator)
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

            if (_showScrollIndicator)
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
        ),
      ),
    );
  }
}