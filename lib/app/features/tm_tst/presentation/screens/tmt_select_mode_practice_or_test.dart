import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../constans/app_constants.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../domain/entities/result/tmt_game_hand_used.dart';
import '../../domain/entities/result/tmt_game_init_data.dart';
import '../../domain/usecases/select_mode_practice_or_test_responsive_calculate.dart';
import '../components/tmt_select_hand_dialog.dart';
import '../screens/tmt_test_help.dart';

class SelectModePracticeOrTest extends StatelessWidget with NavigationMixin {
  SelectModePracticeOrTest({super.key});

  final String tmtGameCodeId = "74829-23"; //TODO parse from HomeScreen

  bool get isDarkMode => Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    final isTablet = DeviceHelper.isTablet;
    final cardWidth =
        SelectModePracticeOrTestCalculate.calculateCardWidth(context);

    return Scaffold(
      appBar: CustomAppBar(title: SelectModePracticeOrTestText.title.tr),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 26),
              Text(
                SelectModePracticeOrTestText.questionText.tr,
                style: AppTextStyle.selectModeTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 88),
              isLandscape && !isTablet
                  ? _buildLandscapeLayout(context)
                  : _buildPortraitLayout(context, cardWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, double cardWidth) {
    return Column(
      children: [
        SizedBox(
          width: cardWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: _buildOptionCard(
              context: context,
              title: SelectModePracticeOrTestText.practiceButtonText.tr,
              onTap: () {
                tmtTestToHelp(TmtHelpMode.TMT_PRACTICE_A);
              },
              isPractice: true,
            ),
          ),
        ),
        const SizedBox(height: 52),
        SizedBox(
          width: cardWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: _buildOptionCard(
              context: context,
              title: SelectModePracticeOrTestText.testButtonText.tr,
              onTap: () async {
                TmtGameHandUsed selectedHand =
                    await showTmtSelectHandDialogGetX();
                toTmtTest(TmtGameInitData(
                  tmtGameHandUsed: selectedHand,
                  tmtGameCodeId: tmtGameCodeId,
                ));
              },
              isPractice: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    final cardWidth =
        SelectModePracticeOrTestCalculate.calculateCardWidth(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: cardWidth,
            child: _buildOptionCard(
              context: context,
              title: SelectModePracticeOrTestText.practiceButtonText.tr,
              onTap: () {
                tmtTestToHelp(TmtHelpMode.TMT_PRACTICE_A);
              },
              isPractice: true,
            ),
          ),
          const SizedBox(width: 52),
          SizedBox(
            width: cardWidth,
            child: _buildOptionCard(
              context: context,
              title: SelectModePracticeOrTestText.testButtonText.tr,
              onTap: () async {
                TmtGameHandUsed selectedHand =
                    await showTmtSelectHandDialogGetX();
                toTmtTest(TmtGameInitData(
                  tmtGameHandUsed: selectedHand,
                  tmtGameCodeId: tmtGameCodeId,
                ));
              },
              isPractice: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    required bool isPractice,
  }) {
    final Color outerCardColor = isDarkMode
        ? AppColors.secondaryBlueDark.withAlpha(178)
        : AppColors.secondaryBlueClear;

    final Color innerCardColor =
        isDarkMode ? AppColors.secondaryBlueDark : AppColors.secondaryBlue;

    final double cardHeight =
        SelectModePracticeOrTestCalculate.calculateCardHeight(context);

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: outerCardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                color: innerCardColor,
                child: InkWell(
                  splashColor: isDarkMode
                      ? Colors.white.withAlpha(51)
                      : AppColors.primaryBlue.withAlpha(51),
                  highlightColor: isDarkMode
                      ? Colors.white.withAlpha(25)
                      : AppColors.primaryBlue.withAlpha(25),
                  onTap: onTap,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyleBase.h2.copyWith(
                        color: isDarkMode
                            ? AppColors.darkText
                            : AppColors.blueText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 36),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: isDarkMode
                    ? Colors.white.withAlpha(51)
                    : AppColors.primaryBlue.withAlpha(51),
                onTap: () {
                  _showHelpDialog(context, isPractice);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isDarkMode
                      ? SvgPicture.asset(
                          ImageVectorPath.help,
                          width: 30,
                          height: 30,
                          colorFilter: const ColorFilter.mode(
                            AppColors.darkText,
                            BlendMode.srcIn,
                          ),
                        )
                      : SvgPicture.asset(
                          ImageVectorPath.help,
                          width: 30,
                          height: 30,
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context, bool isPractice) {
    if (isPractice) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          title: SelectModePracticeOrTestText.practiceModeTitle.tr,
          content: SelectModePracticeOrTestText.practiceModeContent.tr,
          mode: DialogMode.singleButton,
          primaryButtonText: SelectModePracticeOrTestText.buttonUnderstood.tr,
          onPrimaryPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          title: SelectModePracticeOrTestText.testModeTitle.tr,
          content: SelectModePracticeOrTestText.testModeContent.tr,
          mode: DialogMode.singleButton,
          primaryButtonText: SelectModePracticeOrTestText.buttonUnderstood.tr,
          onPrimaryPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }
}
