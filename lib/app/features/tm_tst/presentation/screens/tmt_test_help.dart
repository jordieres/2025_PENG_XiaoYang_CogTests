import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../../../utils/helpers/widget_max_width_calculator.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../../home/domain/entities/reference_validation_result_entity.dart';
import '../../domain/entities/result/tmt_game_hand_used.dart';
import '../components/tmt_select_hand_dialog.dart';
import '../newscreens/new_tmt_test_flow_contoller.dart';

enum TmtHelpMode { TMT_TEST_GENERAL, TMT_TEST_A, TMT_TEST_B }

class TmtTestHelpPage extends StatefulWidget with NavigationMixin {
  const TmtTestHelpPage({super.key});

  @override
  State<TmtTestHelpPage> createState() => _TmtTestHelpPageState();
}

class _TmtTestHelpPageState extends State<TmtTestHelpPage> {
  late TmtHelpMode tmtHelpMode;
  String tmtGameCodeId = "";
  HandsUsed handsUsed = HandsUsed.NONE;
  late TmtTestNavigationFlowController tmtTestNewFlowController;

  // Nuevas propiedades para el indicador de desplazamiento
  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = false;

  @override
  void initState() {
    super.initState();
    try {
      tmtHelpMode = Get.arguments as TmtHelpMode;
      tmtTestNewFlowController = Get.find<TmtTestNavigationFlowController>();
    } catch (e) {
      tmtHelpMode = TmtHelpMode.TMT_TEST_A;
    }

    // Configurar el verificador de estado de desplazamiento
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollStatus();
    });

    // Añadir listener al controlador de desplazamiento
    _scrollController.addListener(_onScroll);
  }

  // Verificar si hay contenido que se puede desplazar
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

  // Actualizar la visibilidad del indicador al desplazarse
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

  // Desplazarse hacia abajo cuando se hace clic en el indicador
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Construir el indicador de desplazamiento
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _getHelpTitle(TmtHelpMode tmtHelpMode) {
    switch (tmtHelpMode) {
      case TmtHelpMode.TMT_TEST_GENERAL:
        return TMTGameText.tmtGameTmtHelpGeneralTitle.tr;
      case TmtHelpMode.TMT_TEST_A:
        return TMTGameText.tmtGameTmtHelpTmtATitle.tr;
      case TmtHelpMode.TMT_TEST_B:
        return TMTGameText.tmtGameTmtHelpTmtBTitle.tr;
    }
  }

  String _getHelpDescription(TmtHelpMode tmtHelpMode) {
    switch (tmtHelpMode) {
      case TmtHelpMode.TMT_TEST_GENERAL:
        return TMTGameText.tmtGameTmtHelpGeneralDescription.tr;
      case TmtHelpMode.TMT_TEST_A:
        return TMTGameText.tmtGameTmtHelpTmtADescription.tr;
      case TmtHelpMode.TMT_TEST_B:
        return TMTGameText.tmtGameTmtHelpTmtBDescription.tr;
    }
  }

  void _toPracticePage(TmtHelpMode tmtHelpMode) {
    switch (tmtHelpMode) {
      case TmtHelpMode.TMT_TEST_GENERAL:
        _handleTestModeSelection();
        break;
      case TmtHelpMode.TMT_TEST_A:
        tmtTestNewFlowController.advanceState();
        break;
      case TmtHelpMode.TMT_TEST_B:
        tmtTestNewFlowController.advanceState();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _getHelpTitle(tmtHelpMode),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final buttonsHeight = DeviceHelper.isTablet ? 130.0 : 120.0;
                final textWidget = Text(
                  _getHelpDescription(tmtHelpMode),
                  textAlign: TextAlign.left,
                  style: TextStyleBase.bodyL,
                );

                final TextPainter textPainter = TextPainter(
                  text: TextSpan(
                      text: _getHelpDescription(tmtHelpMode),
                      style: TextStyleBase.bodyL),
                  textDirection: TextDirection.ltr,
                  maxLines: null,
                  textAlign: TextAlign.left,
                )..layout(maxWidth: constraints.maxWidth - 48);

                final textHeight = textPainter.height;
                final availableSpace =
                    constraints.maxHeight - textHeight - buttonsHeight;
                final spacing = availableSpace / 2;

                return SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: SizedBox(
                          width: WidgetMaxWidthCalculator.getMaxWidth(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWidget,
                              SizedBox(height: spacing > 0 ? spacing : 40),
                              Center(
                                child: SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomPrimaryButton(
                                        text: _getButtonText(tmtHelpMode),
                                        onPressed: () {
                                          _toPracticePage(tmtHelpMode);
                                        },
                                      ),
                                      SizedBox(
                                          height:
                                              DeviceHelper.isTablet ? 18 : 12),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (_showScrollIndicator) _buildScrollIndicator(),
          ],
        ),
      ),
    );
  }

  String _getButtonText(TmtHelpMode tmtHelpMode) {
    switch (tmtHelpMode) {
      case TmtHelpMode.TMT_TEST_GENERAL:
        return TMTGameText.tmtGameTmtHelpGeneralButtonText.tr;
      case TmtHelpMode.TMT_TEST_A:
        return TMTGameText.tmtGameTmtHelpTmtAButtonText.tr;
      case TmtHelpMode.TMT_TEST_B:
        return TMTGameText.tmtGameTmtHelpTmtBButtonText.tr;
    }
  }

  Future<void> _handleTestModeSelection() async {
    TmtGameHandUsed? selectedHand =
        await showTmtSelectHandDialogGetX(handsUsed);
    if (selectedHand != null) {
      tmtTestNewFlowController.saveTmtGameInitData(selectedHand);
    }
    setState(() {
      tmtHelpMode = TmtHelpMode.TMT_TEST_A;
    });
  }
}
