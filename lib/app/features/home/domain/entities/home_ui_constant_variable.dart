import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/AppColors.dart';

class HomeUIConstantVariable {
  static const _enableOpacity = 1.0;
  static const _disableOpacity = 0.1;
  static const _disableOpacityForReferenceValidation = 0.3;

  static const double tmtTestButtonCardHeight = 162;
  static const double buttonCardMiddleHeight = 80;
  static const double buttonCardHeight = 100;
  static const double cardHorizontalPadding = 24.0;

  static double getOpacityDependIsEnable(bool isEnable) {
    return isEnable ? _enableOpacity : _disableOpacity;
  }

  static double getOpacityDependIsEnableReferenceValidation(bool isEnable) {
    return isEnable ? _enableOpacity : _disableOpacityForReferenceValidation;
  }

  static const cardCornerRadius = 10.0;

  static final Icon _lockIcon = Icon(
    Icons.lock_outline,
    color: AppColors.mainRed,
    size: 36,
  );

  static Widget lockIconWidget = Positioned.fill(
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(8),
       /* decoration: BoxDecoration(
          color: Color(0xFFB8B3B3),
          shape: BoxShape.circle,
        ),*/
        child: HomeUIConstantVariable._lockIcon,
      ),
    ),
  );
}
