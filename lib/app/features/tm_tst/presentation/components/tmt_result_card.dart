import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/AppFontWeight.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../domain/usecases/tmt_result/tmt_result_card_responsive_calculate.dart';

class TmtResultCard extends StatelessWidget {
  final String title;
  final String duration;
  final String errors;

  const TmtResultCard({
    super.key,
    required this.title,
    required this.duration,
    required this.errors,
  });

  @override
  Widget build(BuildContext context) {
    final metrics =
        TmtResultCardResponsiveCalculator.calculateCardMetrics(context);

    return Center(
      child: Container(
        width: metrics.maxCardWidth,
        margin: EdgeInsets.symmetric(vertical: metrics.verticalMargin),
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? AppColors.secondaryBlueDark
              : AppColors.secondaryBlue,
          borderRadius: BorderRadius.circular(metrics.borderRadius),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: metrics.topPadding),
              child: Text(
                title,
                style: TextStyleBase.h1,
              ),
            ),
            SizedBox(height: metrics.titleSpacing),
            LayoutBuilder(
              builder: (context, constraints) {
                final durationLabel = TMTResultScreen.durationLabel.tr;
                final errorsLabel = TMTResultScreen.errorsLabel.tr;

                final durationTextWidth =
                    TmtResultCardResponsiveCalculator.calculateTextWidth(
                  durationLabel,
                  AppTextStyle.tmtResultCardText,
                );

                final errorsTextWidth =
                    TmtResultCardResponsiveCalculator.calculateTextWidth(
                  errorsLabel,
                  AppTextStyle.tmtResultCardText,
                );

                final spacing =
                    TmtResultCardResponsiveCalculator.calculateLayoutSpacing(
                  context,
                  constraints,
                  durationTextWidth,
                  errorsTextWidth,
                );

                return Padding(
                  padding: EdgeInsets.only(
                    left: spacing.leftPadding,
                    right: spacing.rightPadding,
                    bottom: metrics.bottomPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildColumn(
                          durationLabel, duration, metrics.labelValueSpacing),
                      _buildColumn(
                          errorsLabel, errors, metrics.labelValueSpacing),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(String label, String value, double spacing) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyle.tmtResultCardText,
        ),
        SizedBox(height: spacing),
        Text(
          value,
          style: AppTextStyle.tmtResultCardText.copyWith(
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
      ],
    );
  }
}
