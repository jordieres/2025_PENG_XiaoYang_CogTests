import 'package:flutter/material.dart';
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
    // 注意: onPressed 始终传递 onPressed 回调，而不考虑 isEnabled 状态
    // 这样按钮即使在视觉上显示为"禁用"状态，依然可以点击
    return SizedBox(
      width: DeviceHelper.isTablet ? 536 : 311,
      child: ElevatedButton(
        onPressed: onPressed, // 始终可点击，无论 isEnabled 是什么值
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (backgroundColor ?? AppColors.customButtonColor)
              : Colors.grey.shade300, // 根据 isEnabled 改变颜色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size.fromHeight(DeviceHelper.isTablet ? 60 : 48),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: Text(
          text,
          style: AppTextStyle.customPrimaryButtonText.copyWith(
            color: isEnabled ? Colors.white : Colors.grey.shade700, // 根据 isEnabled 改变文字颜色
          ),
        ),
      ),
    );
  }
}