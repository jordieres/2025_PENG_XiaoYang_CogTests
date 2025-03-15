import 'package:flutter/material.dart';
import '../config/themes/AppColors.dart';
import '../config/themes/AppTextStyle.dart';

enum DialogMode { singleButton, twoMainButtons, confirmCancel }

class CustomDialog extends StatelessWidget {
  final String title;
  final dynamic content;
  final DialogMode mode;
  final String primaryButtonText;
  final String? secondaryButtonText;
  final String? rightPrimaryButtonText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final VoidCallback? onSecondPrimaryPressed;

  const CustomDialog({
    Key? key,
    required this.title,
    this.content,
    required this.mode,
    required this.primaryButtonText,
    this.secondaryButtonText,
    this.rightPrimaryButtonText,
    required this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.onSecondPrimaryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? contentWidget;

    if (content != null) {
      if (content is String) {
        contentWidget = Text(
          content,
          style: AppTextStyle.customDialogContent,
          textAlign: TextAlign.center,
        );
      } else if (content is Widget) {
        contentWidget = content;
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
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
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    switch (mode) {
      case DialogMode.singleButton:
        return _buildPrimaryButton(
            context,
            primaryButtonText,
            onPrimaryPressed,
            isFullWidth: true
        );

      case DialogMode.twoMainButtons:
        return Row(
          children: [
            Expanded(
                child: _buildPrimaryButton(
                    context,
                    primaryButtonText,
                    onPrimaryPressed
                )
            ),
            const SizedBox(width: 12.0),
            Expanded(
                child: _buildPrimaryButton(
                    context,
                    rightPrimaryButtonText ?? "",
                    onSecondPrimaryPressed
                )
            ),
          ],
        );

      case DialogMode.confirmCancel:
        return Row(
          children: [
            Expanded(
                child: _buildOutlinedButton(
                    context,
                    secondaryButtonText ?? "",
                    onSecondaryPressed
                )
            ),
            const SizedBox(width: 12.0),
            Expanded(
                child: _buildPrimaryButton(
                    context,
                    primaryButtonText,
                    onPrimaryPressed
                )
            ),
          ],
        );
    }
  }

  Widget _buildPrimaryButton(
      BuildContext context,
      String text,
      VoidCallback? onPressed,
      {bool isFullWidth = false}
      ) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.customDialogButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
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
      BuildContext context,
      String text,
      VoidCallback? onPressed
      ) {
    return OutlinedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
        Navigator.of(context).pop();
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: BorderSide(color: AppColors.customDialogButtonColor),
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