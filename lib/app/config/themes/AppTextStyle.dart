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
    fontSize: DeviceHelper.isTablet ? 28 : 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static var customDialogTitle = TextStyle(
    color: AppColors.customDialogTitleColor,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static var customDialogContent = TextStyle(
    color: Color(0xFF71727A),
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );

  static var customDialogButton = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static var customDialogOutlinedButton = TextStyle(
    color: AppColors.customButtonColor,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

}
