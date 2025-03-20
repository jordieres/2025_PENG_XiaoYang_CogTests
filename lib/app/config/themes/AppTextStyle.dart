import 'package:flutter/material.dart';
import '../../utils/helpers/app_helpers.dart';
import 'AppColors.dart';
import 'AppFontWeight.dart';

class AppTextStyle {
  static var appBarTitle = TextStyle(
    color: AppColors.mainBlackText,
    fontSize: DeviceHelper.isTablet ? 16.0 : 14.0,
    fontWeight: AppFontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static var tmtGameCircleText = TextStyle(
    color: AppColors.mainBlackText,
    fontSize: DeviceHelper.isTablet ? 30 : 22,
    fontWeight: AppFontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static var tmtGameCircleBeginAndLastText = TextStyle(
    color: AppColors.mainBlackText,
    fontSize: DeviceHelper.isTablet ? 28 : 18,
    fontWeight: AppFontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static var customDialogTitle = TextStyle(
    color: AppColors.customDialogTitleColor,
    fontSize: 16.0,
    fontWeight: AppFontWeight.extraBold,
    fontStyle: FontStyle.normal,
  );

  static var customDialogContent = TextStyle(
    color: Color(0xFF71727A),
    fontSize: DeviceHelper.isTablet ? 14 : 12,
    fontWeight: AppFontWeight.normal,
  );

  static var customDialogButton = TextStyle(
    color: Colors.white,
    fontSize: DeviceHelper.isTablet ? 14 : 12,
    fontWeight: AppFontWeight.semiBold,
    fontStyle: FontStyle.normal,
  );

  static var customDialogOutlinedButton = TextStyle(
    color: AppColors.customButtonColor,
    fontSize: DeviceHelper.isTablet ? 14 : 12,
    fontWeight: AppFontWeight.semiBold,
    fontStyle: FontStyle.normal,
  );
}
