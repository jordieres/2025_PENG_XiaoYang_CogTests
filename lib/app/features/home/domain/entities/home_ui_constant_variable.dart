import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/AppColors.dart';

class HomeUIConstantVariable {
  static const enableOpacity = 1.0;
  static const disableOpacity = 0.3;

  static const double tmtTestButtonCardHeight = 142;
  static const double buttonCardHeight = 120;

  static double getOpacityDependIsEnable(bool isEnable) {
    return isEnable ? enableOpacity : disableOpacity;
  }

  static const cardCornerRadius = 10.0;

  static Icon lockIcon = Icon(
    Icons.lock_outline,
    color: AppColors.mainRed.withAlpha(178),
    size: 32,
  );
}
