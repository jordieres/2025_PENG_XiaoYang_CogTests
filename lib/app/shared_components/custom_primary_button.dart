import 'package:flutter/material.dart';
import '../config/themes/AppColors.dart';
import '../config/themes/AppTextStyle.dart';
import '../utils/helpers/app_helpers.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const CustomPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DeviceHelper.isTablet ? 536 : 311,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.customButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size.fromHeight(DeviceHelper.isTablet ? 60 : 48),
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
        ),
        child: Text(
          text,
          style: AppTextStyle.customPrimaryButtonText,
        ),
      ),
    );
  }
}
