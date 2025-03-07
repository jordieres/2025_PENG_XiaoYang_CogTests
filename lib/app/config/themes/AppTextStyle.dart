import 'package:flutter/material.dart';
import '../../utils/helpers/app_helpers.dart';
import 'AppColors.dart';

class AppTextStyle {

  static var tmtGameCircleText = TextStyle(
    color: AppColors.mainBlackText,
    fontSize: DeviceHelper.isTablet ? 30 : 22,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static var tmtGameCircleBeginAndLastText = TextStyle(
    color: AppColors.mainBlackText,
    fontSize: DeviceHelper.isTablet ? 26 : 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

}
