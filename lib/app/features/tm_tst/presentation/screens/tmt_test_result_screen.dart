import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
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
  double _cardHeight = 0;

  // Valores de margen basados en la altura de la tarjeta
  double _cardsToTextMargin = 0;
  double _textToButtonMargin = 0;

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

      // Calcular los márgenes basados en la altura de la tarjeta
      final baseSpacing = height * 0.685;
      setState(() {
        _cardHeight = height;
        _cardsToTextMargin = baseSpacing * 0.6; // 60% para cardsToTextMargin
        _textToButtonMargin = baseSpacing * 0.4; // 40% para textToButtonMargin
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
      final contentHeight = contentBox.size.height;
      final screenHeight = MediaQuery.of(context).size.height;

      setState(() {
        _showScrollIndicator = contentHeight > screenHeight;
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

  // Función para determinar el factor de escala basado en el tipo de dispositivo
  double _getScaleFactor() {
    // Obtener el tipo de dispositivo desde DeviceHelper
    final deviceType = DeviceHelper.deviceType;

    // Ajustar el factor de escala según el tipo de tablet
    switch (deviceType) {
      case DeviceType.largeTablet:
        return 1.6;
      case DeviceType.mediumTablet:
        return 1.4;
      case DeviceType.smallTablet:
        return 1.3;
      case DeviceType.largePhone:
        return 1.0;
      case DeviceType.mediumPhone:
        return 1.0;
      case DeviceType.smallPhone:
        return 0.9;
    }
  }

  @override
  Widget build(BuildContext context) {
    DeviceHelper.init(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Usar DeviceHelper para detectar si es tablet
    final bool isTablet = DeviceHelper.isTablet;

    // Factor de escala ajustado según el tipo específico de dispositivo
    final double baseScaleFactor = _getScaleFactor();

    // Calcular el ratio responsivo sin restringirlo
    final responsiveRatio = screenHeight / 812.0;

    // Aplicar escalado sin restricciones para permitir crecimiento proporcional en tablets
    final topMargin = 46 * responsiveRatio * baseScaleFactor;

    // Nuevos márgenes según el diseño
    final titleToSessionsMargin = isLandscape
        ? 30 * responsiveRatio * baseScaleFactor
        : 40 * responsiveRatio * baseScaleFactor;
    final sessionsToCardMargin = 28 * responsiveRatio * baseScaleFactor;
    final betweenCardsMargin = 28 * responsiveRatio * baseScaleFactor;
    final fixedCardsToTextMargin = isLandscape
        ? 58 * responsiveRatio * baseScaleFactor
        : 40 * responsiveRatio * baseScaleFactor;
    final fixedTextToButtonMargin = isLandscape
        ? 28 * responsiveRatio * baseScaleFactor
        : 38 * responsiveRatio * baseScaleFactor;
    final horizontalCardSpacing = 16 * (screenWidth / 375) * baseScaleFactor;
    final bottomMargin = isLandscape
        ? 60 * responsiveRatio * baseScaleFactor
        : 40 * responsiveRatio * baseScaleFactor;

    // Determinar si usar valores fijos o proporcionales
    final useProportionalMargins = isTablet || !isLandscape;

    // Determinar el ancho del contenido
    // Para tablets en modo landscape, limitamos el ancho al 70% de la pantalla
    final contentMaxWidth = (isTablet && isLandscape)
        ? screenWidth * 0.7 // 70% del ancho para tablets en horizontal
        : double.infinity; // Sin límite para otros casos

    // Mock data for UI testing
    final int timeCompleteA = 30;
    final int timeCompleteB = 30;
    final int errorsA = 1;
    final int errorsB = 1;
    final int numSessions = 3;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Center(
                // Centrar todo el contenido
                child: Container(
                  key: _contentKey,
                  constraints: BoxConstraints(
                    maxWidth: contentMaxWidth,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: (isTablet && isLandscape)
                          ? 0 // Sin padding adicional para tablets en horizontal
                          : screenWidth *
                              0.04 // Padding normal para otros casos
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: topMargin),
                      Center(
                        child: Text(
                          'Resultado:',
                          style: TextStyleBase.h1,
                        ),
                      ),
                      SizedBox(height: titleToSessionsMargin),
                      // Nuevo elemento: Número de Sesiones
                      Center(
                        child: Text(
                          'Número de Sesiones $numSessions',
                          style: TextStyleBase.h2,
                        ),
                      ),
                      SizedBox(height: sessionsToCardMargin),
                      // Contenedor para las tarjetas con ancho limitado en tablets
                      Container(
                        width: isTablet && !isLandscape
                            ? screenWidth * 0.8
                            : double.infinity,
                        child: isLandscape
                            ? Row(
                                children: [
                                  Expanded(
                                    child: TmtResultCard(
                                      key: _cardKey,
                                      title: 'TMT A',
                                      duration: '$timeCompleteA S',
                                      errors: errorsA.toString(),
                                    ),
                                  ),
                                  SizedBox(width: horizontalCardSpacing),
                                  Expanded(
                                    child: TmtResultCard(
                                      title: 'TMT A',
                                      duration: '$timeCompleteB S',
                                      errors: errorsB.toString(),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  TmtResultCard(
                                    key: _cardKey,
                                    title: 'TMT A',
                                    duration: '$timeCompleteA S',
                                    errors: errorsA.toString(),
                                  ),
                                  SizedBox(height: betweenCardsMargin),
                                  TmtResultCard(
                                    title: 'TMT A',
                                    duration: '$timeCompleteB S',
                                    errors: errorsB.toString(),
                                  ),
                                ],
                              ),
                      ),
                      // Usar el margen calculado si corresponde, o el fijo en caso contrario
                      SizedBox(
                          height:
                              useProportionalMargins && _cardsToTextMargin > 0
                                  ? _cardsToTextMargin
                                  : fixedCardsToTextMargin),
                      Text(
                        'Le agradecemos la confianza, el tiempo y el esfuerzo\nen realizar este test dTMT',
                        style: TextStyleBase.bodyS,
                        textAlign: TextAlign.center,
                      ),
                      // Usar el margen calculado si corresponde, o el fijo en caso contrario
                      SizedBox(
                          height:
                              useProportionalMargins && _textToButtonMargin > 0
                                  ? _textToButtonMargin
                                  : fixedTextToButtonMargin),
                      CustomPrimaryButton(
                        text: 'Terminar',
                        onPressed: () {
                          // Get.offAllNamed(Routes.home);
                        },
                      ),
                      SizedBox(height: bottomMargin),
                    ],
                  ),
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
