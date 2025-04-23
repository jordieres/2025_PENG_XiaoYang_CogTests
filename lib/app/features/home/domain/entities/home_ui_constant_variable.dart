import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/AppColors.dart';

class HomeUIConstantVariable {
  static const enableOpacity = 1.0;
  static const disableOpacity = 0.25;

  static const double tmtTestButtonCardHeight = 142;
  static const double buttonCardHeight = 120;
  static const double cardHorizontalPadding = 24.0;

  static double getOpacityDependIsEnable(bool isEnable) {
    return isEnable ? enableOpacity : disableOpacity;
  }

  static const cardCornerRadius = 10.0;

  static Icon lockIcon = Icon(
    Icons.lock_outline,
    color: AppColors.mainRed,
    size: 36,
  );

  static Widget lockIconWidget = Positioned.fill(
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFB8B3B3),
          shape: BoxShape.circle,
        ),
        child: HomeUIConstantVariable.lockIcon,
      ),
    ),
  );
}
