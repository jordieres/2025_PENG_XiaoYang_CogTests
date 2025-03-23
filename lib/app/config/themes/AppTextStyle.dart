import 'package:flutter/material.dart';
import '../../utils/helpers/app_helpers.dart';
import 'AppColors.dart';
import 'AppFontWeight.dart';

class AppTextStyle {


  static const double _largeTextSize = 30.0;
  static const double _bigTextSize = 24.0;
  static const double _normalTextSize = 18.0;
  static const double _middleTextWhiteSize = 16.0;
  static const double _smallTextSize = 14.0;
  static const double _minTextSize = 12.0;

  // Tablet size getters
  static const double tabletSizeIncrement = 2.0;

  static  double largeTextSize = DeviceHelper.isTablet ? _largeTextSize + tabletSizeIncrement : _largeTextSize;
  static  double bigTextSize = DeviceHelper.isTablet ? _bigTextSize + tabletSizeIncrement : _bigTextSize;
  static  double normalTextSize = DeviceHelper.isTablet ? _normalTextSize + tabletSizeIncrement : _normalTextSize;
  static  double middleTextWhiteSize = DeviceHelper.isTablet ? _middleTextWhiteSize + tabletSizeIncrement : _middleTextWhiteSize;
  static  double smallTextSize = DeviceHelper.isTablet ? _smallTextSize + tabletSizeIncrement : _smallTextSize;
  static  double minTextSize = DeviceHelper.isTablet ? _minTextSize + tabletSizeIncrement : _minTextSize;


  static var appBarTitle = TextStyle(
    color: AppColors.mainBlackText,
    fontSize: middleTextWhiteSize,
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
    fontSize: middleTextWhiteSize,
    fontWeight: AppFontWeight.extraBold,
    fontStyle: FontStyle.normal,
  );

  static var customDialogContent = TextStyle(
    color: AppColors.customDialogContentColor,
    fontSize:minTextSize,
    fontWeight: AppFontWeight.normal,
  );

  static var customDialogButton = TextStyle(
    color: Colors.white,
    fontSize:minTextSize,
    fontWeight: AppFontWeight.semiBold,
    fontStyle: FontStyle.normal,
  );

  static var customDialogOutlinedButton = TextStyle(
    color: AppColors.customButtonColor,
    fontSize: minTextSize,
    fontWeight: AppFontWeight.semiBold,
    fontStyle: FontStyle.normal,
  );
}
