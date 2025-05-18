import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../constans/app_constants.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../../../utils/helpers/widget_max_width_calculator.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../../home/domain/entities/reference_validation_result_entity.dart';
import '../../domain/entities/result/tmt_game_hand_used.dart';
import '../components/tmt_select_hand_dialog.dart';
import '../newscreens/tmt_test_navigation_flow.dart';

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

  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = false;

  final double imageSpacing = 30;
  final double maxImageHeight = 330;

  @override
  void initState() {
    super.initState();
    try {
      tmtHelpMode = Get.arguments as TmtHelpMode;
    } catch (e) {
      tmtHelpMode = TmtHelpMode.TMT_TEST_A;
    }
    try {
      tmtTestNewFlowController = Get.find<TmtTestNavigationFlowController>();
    } catch (e) {
      tmtTestNewFlowController = TmtTestNavigationFlowController();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollStatus();
    });

    _scrollController.addListener(_onScroll);
  }

  double _getAspectRatio(double screenWidth) {
    if (screenWidth > 1000) {
      return 2;
    } else if (DeviceHelper.isTablet) {
      return 16 / 9;
    } else {
      return 4 / 3;
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

  String? _getAnimationPath(TmtHelpMode tmtHelpMode) {
    if (tmtHelpMode == TmtHelpMode.TMT_TEST_GENERAL) {
      return null;
    }
    TmtGameHandUsed handUsed;
    try {
      handUsed = tmtTestNewFlowController.tmtGameInitData.tmtGameHandUsed;
    } catch (e) {
      handUsed = TmtGameHandUsed.LEFT;
    }

    if (tmtHelpMode == TmtHelpMode.TMT_TEST_A) {
      return handUsed == TmtGameHandUsed.LEFT
          ? GifPath.tmtAAnimationLeftHand
          : GifPath.tmtAAnimationRightHand;
    } else if (tmtHelpMode == TmtHelpMode.TMT_TEST_B) {
      return handUsed == TmtGameHandUsed.LEFT
          ? GifPath.tmtBAnimationLeftHand
          : GifPath.tmtBAnimationRightHand;
    }

    return null;
  }

  double _calculateContentSpacing(double constraintsWidth,
      double constraintsHeight, double textHeight, bool hasAnimation) {
    final buttonsHeight = DeviceHelper.isTablet ? 130.0 : 120.0;

    final actualWidth = constraintsWidth - 48;
    final aspectRatio = _getAspectRatio(constraintsWidth);
    final rawImageHeight = actualWidth / aspectRatio;

    final calculatedImageHeight = hasAnimation
        ? (rawImageHeight > maxImageHeight ? maxImageHeight : rawImageHeight) +
            imageSpacing
        : 0.0;

    final availableSpace =
        constraintsHeight - textHeight - buttonsHeight - calculatedImageHeight;
    return availableSpace > 40 ? availableSpace / 2.5 : 40.0;
  }

  Widget _buildCustomPrimaryButton() {
    final isInActiveTestState =
        tmtTestNewFlowController.tmtTestFlowState.value ==
                TmtTestNavigationFlow.TMT_A_IN_PROGRESS ||
            tmtTestNewFlowController.tmtTestFlowState.value ==
                TmtTestNavigationFlow.TMT_B_IN_PROGRESS;

    String buttonText;
    if (isInActiveTestState) {
      buttonText = "Volver";
    } else {
      switch (tmtHelpMode) {
        case TmtHelpMode.TMT_TEST_GENERAL:
          buttonText = TMTGameText.tmtGameTmtHelpGeneralButtonText.tr;
          break;
        case TmtHelpMode.TMT_TEST_A:
          buttonText = TMTGameText.tmtGameTmtHelpTmtAButtonText.tr;
          break;
        case TmtHelpMode.TMT_TEST_B:
          buttonText = TMTGameText.tmtGameTmtHelpTmtBButtonText.tr;
          break;
      }
    }

    return CustomPrimaryButton(
      text: buttonText,
      onPressed: () {
        if (isInActiveTestState) {
          Get.back();
        } else {
          switch (tmtHelpMode) {
            case TmtHelpMode.TMT_TEST_GENERAL:
              _handleTestModeSelection();
              break;
            case TmtHelpMode.TMT_TEST_A:
            case TmtHelpMode.TMT_TEST_B:
              tmtTestNewFlowController.advanceState();
              break;
          }
        }
      },
    );
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
                final textWidget = Text(
                  _getHelpDescription(tmtHelpMode),
                  textAlign: TextAlign.left,
                  style: TextStyleBase.bodyL,
                );

                final String? animationPath = _getAnimationPath(tmtHelpMode);
                final bool hasAnimation = animationPath != null;
                final aspectRatio = _getAspectRatio(constraints.maxWidth);

                final TextPainter textPainter = TextPainter(
                  text: TextSpan(
                      text: _getHelpDescription(tmtHelpMode),
                      style: TextStyleBase.bodyL),
                  textDirection: TextDirection.ltr,
                  maxLines: null,
                  textAlign: TextAlign.left,
                )..layout(maxWidth: constraints.maxWidth - 48);

                final spacing = _calculateContentSpacing(
                  constraints.maxWidth,
                  constraints.maxHeight,
                  textPainter.height,
                  hasAnimation,
                );

                final actualWidth = constraints.maxWidth - 48;
                final rawImageHeight = actualWidth / aspectRatio;
                final imageHeight = rawImageHeight > maxImageHeight
                    ? maxImageHeight
                    : rawImageHeight;

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
                              if (hasAnimation) ...[
                                SizedBox(height: imageSpacing),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: imageHeight,
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: aspectRatio,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                            animationPath,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              SizedBox(height: spacing),
                              Center(
                                child: SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildCustomPrimaryButton(),
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

  Future<void> _handleTestModeSelection() async {
    TmtGameHandUsed? selectedHand =
        await showTmtSelectHandDialogGetX(handsUsed);
    if (selectedHand != null) {
      tmtTestNewFlowController.saveTmtGameInitData(selectedHand);
    }
    setState(() {
      tmtHelpMode = TmtHelpMode.TMT_TEST_A;
    });

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }
}
