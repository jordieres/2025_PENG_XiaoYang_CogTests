import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../config/themes/AppColors.dart';
import '../config/themes/AppTextStyle.dart';

enum DialogMode { singleButton, twoMainButtons, confirmCancel }

class CustomDialog extends StatelessWidget {
  final String title;
  final dynamic content;
  final DialogMode mode;
  final String primaryButtonText;
  final String? cancelButtonText;
  final String? onLeftPrimaryButtonText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback? onCancelPressed;
  final VoidCallback? onLeftPrimaryPressed;
  final bool dismissibleByBackButton;

  const CustomDialog(
      {Key? key,
      required this.title,
      required this.mode,
      required this.primaryButtonText,
      required this.onPrimaryPressed,
      this.content,
      this.cancelButtonText,
      this.onCancelPressed,
      this.onLeftPrimaryButtonText,
      this.onLeftPrimaryPressed,
      this.dismissibleByBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? contentWidget;

    final orientation = MediaQuery.of(context).orientation;
    final screenWidth = MediaQuery.of(context).size.width;

    final maxWidth = orientation == Orientation.landscape
        ? screenWidth * 0.5
        : screenWidth * 0.8;

    if (content != null) {
      if (content is String) {
        contentWidget = Text(
          content,
          style: AppTextStyle.customDialogContent(Get.isDarkMode),
          textAlign: TextAlign.center,
        );
      } else if (content is Widget) {
        contentWidget = content;
      }
    }

    final dialogContent = Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyle.customDialogTitle,
            textAlign: TextAlign.center,
          ),
          if (contentWidget != null) ...[
            const SizedBox(height: 16.0),
            contentWidget,
          ],
          SizedBox(height: contentWidget != null ? 24.0 : 20.0),
          _buildButtons(context),
        ],
      ),
    );

    return PopScope(
      canPop: dismissibleByBackButton,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: dialogContent,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    switch (mode) {
      case DialogMode.singleButton:
        return _buildPrimaryButton(context, primaryButtonText, onPrimaryPressed,
            isFullWidth: true);

      case DialogMode.twoMainButtons:
        return Row(
          children: [
            Expanded(
                child: _buildPrimaryButton(context,
                    onLeftPrimaryButtonText ?? "", onLeftPrimaryPressed)),
            const SizedBox(width: 12.0),
            Expanded(
                child: _buildPrimaryButton(
                    context, primaryButtonText, onPrimaryPressed)),
          ],
        );

      case DialogMode.confirmCancel:
        return Row(
          children: [
            Expanded(
                child: _buildOutlinedButton(
                    context, cancelButtonText ?? "", onCancelPressed)),
            const SizedBox(width: 12.0),
            Expanded(
                child: _buildPrimaryButton(
                    context, primaryButtonText, onPrimaryPressed)),
          ],
        );
    }
  }

  Widget _buildPrimaryButton(
      BuildContext context, String text, VoidCallback? onPressed,
      {bool isFullWidth = false}) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.customButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            text,
            style: AppTextStyle.customDialogButton,
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(
      BuildContext context, String text, VoidCallback? onPressed) {
    return OutlinedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          color: AppColors.customButtonColor,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          text,
          style: AppTextStyle.customDialogOutlinedButton,
        ),
      ),
    );
  }
}
