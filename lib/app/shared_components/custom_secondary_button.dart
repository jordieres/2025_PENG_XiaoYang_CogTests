import 'package:flutter/material.dart';
import '../config/themes/AppColors.dart';
import '../utils/helpers/app_helpers.dart';

class CustomSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomSecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(0, 40),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.customButtonColor,
          fontSize: DeviceHelper.isTablet ? 16 : 12,
          fontWeight: FontWeight.w600, // semibold
        ),
      ),
    );
  }
}
