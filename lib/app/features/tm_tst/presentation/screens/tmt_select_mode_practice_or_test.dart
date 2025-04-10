import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../constans/app_constants.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../domain/usecases/select_mode_practice_or_test_responsive_calculate.dart';
import '../screens/tmt_test_help.dart';

class SelectModePracticeOrTest extends StatelessWidget with NavigationMixin {
  const SelectModePracticeOrTest({Key? key}) : super(key: key);

  bool get isDarkMode => Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    final isTablet = DeviceHelper.isTablet;
    final cardWidth =
        SelectModePracticeOrTestCalculate.calculateCardWidth(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Seleccionar Modo'),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 26),
              Text(
                '¿Qué modalidad prefieres?',
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
              title: 'Práctica',
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
              title: 'Test Formal',
              onTap: () {
                toTmtTest();
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
              title: 'Práctica',
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
              title: 'Test Formal',
              onTap: () {
                toTmtTest();
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
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: innerCardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyleBase.h2.copyWith(
                      color:
                          isDarkMode ? AppColors.darkText : AppColors.blueText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 36),
          IconButton(
            icon: isDarkMode
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
            onPressed: () {
              _showHelpDialog(context, isPractice);
            },
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
          title: 'Modo Práctica',
          content:
              'En este modo, podrás practicar el test sin que se registren tus resultados oficiales. Es ideal para que te familiarices con el procedimiento y puedas corregir errores sin presión.',
          mode: DialogMode.singleButton,
          primaryButtonText: 'Entendido',
          onPrimaryPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          title: 'Test Formal',
          content:
              'Selecciona este modo para iniciar el test evaluativo. Aquí se registrarán tus tiempos y errores para calcular tu score. Asegúrate de estar listo, ya que este test se considera definitivo.',
          mode: DialogMode.singleButton,
          primaryButtonText: 'Entendido',
          onPrimaryPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }
}
