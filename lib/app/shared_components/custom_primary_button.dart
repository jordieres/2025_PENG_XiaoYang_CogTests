import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../config/themes/AppColors.dart';
import '../config/themes/AppTextStyle.dart';
import '../utils/helpers/app_helpers.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final bool isEnabled;

  const CustomPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.isDarkMode;
    final Color disabledBgColor = isDarkMode
        ? AppColors.customPrimaryButtonDisabledBackgroundColorDark
        : AppColors.customPrimaryButtonDisabledBackgroundColor;
    final Color disabledTextColor = isDarkMode
        ? AppColors.customPrimaryButtonDisabledTextColorDark
        : AppColors.customPrimaryButtonDisabledTextColor;

    return SizedBox(
      width: DeviceHelper.isTablet ? 536 : 311,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (backgroundColor ?? AppColors.customButtonColor)
              : disabledBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size.fromHeight(DeviceHelper.isTablet ? 60 : 48),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: Text(
          text,
          style: AppTextStyle.customPrimaryButtonText.copyWith(
            color: isEnabled ? Colors.white : disabledTextColor,
          ),
        ),
      ),
    );
  }
}
