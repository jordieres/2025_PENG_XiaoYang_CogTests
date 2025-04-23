import 'package:flutter/material.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../domain/entities/home_ui_constant_variable.dart';

class HomeCardButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool middleHeight;
  final IconData? icon;
  final bool isActive;

  const HomeCardButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.middleHeight = false,
    this.icon,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Card(
          elevation: 0,
          color: isDarkMode
              ? AppColors.secondaryBlueDark
              : AppColors.secondaryBlueClear,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(HomeUIConstantVariable.cardCornerRadius),
          ),
          child: Opacity(
            opacity: HomeUIConstantVariable.getOpacityDependIsEnable(isActive),
            child: SizedBox(
              height: middleHeight
                  ? HomeUIConstantVariable.tmtTestButtonCardHeight / 2
                  : HomeUIConstantVariable.tmtTestButtonCardHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    HomeUIConstantVariable.cardCornerRadius),
                child: Material(
                  color: isDarkMode
                      ? AppColors.secondaryBlueDark
                      : AppColors.secondaryBlue,
                  child: InkWell(
                    splashColor: isDarkMode
                        ? Colors.white.withAlpha(51)
                        : AppColors.getPrimaryBlueColor().withAlpha(51),
                    highlightColor: isDarkMode
                        ? Colors.white.withAlpha(25)
                        : AppColors.getPrimaryBlueColor().withAlpha(25),
                    onTap: isActive ? onPressed : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal:
                              HomeUIConstantVariable.cardHorizontalPadding),
                      child: Center(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
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
            ),
          ),
        ),
        if (!isActive) HomeUIConstantVariable.lockIconWidget,
      ],
    );
  }
}
