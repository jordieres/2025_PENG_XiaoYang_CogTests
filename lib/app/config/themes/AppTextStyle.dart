import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/helpers/app_helpers.dart';
import 'AppColors.dart';
import 'AppFontWeight.dart';
import 'app_text_style_base.dart';

class AppTextStyle {
  static var appBarTitle = (TextStyleBase.h4).copyWith();

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

  static var customDialogTitle = (TextStyleBase.h3).copyWith();

  static TextStyle customDialogContent(bool isDarkMode) {
    return (TextStyleBase.bodyS).copyWith(
        color: isDarkMode
            ? AppColors.darkText
            : AppColors.customDialogContentColor);
  }

  static var customDialogButton = (TextStyleBase.actionM).copyWith(
    color: AppColors.darkText,
  );

  static var customDialogOutlinedButton =
      (TextStyleBase.actionM).copyWith(color: AppColors.customButtonColor);

  static var customPrimaryButtonText = (TextStyleBase.actionM).copyWith(
    color: AppColors.darkText,
  );

  static var tmtResultCardText = TextStyle(
    fontSize: DeviceHelper.isTablet ? 22 * TextStyleBase.tabletScaleFactor : 22,
    fontWeight: AppFontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static var tmtResultThanksText = TextStyleBase.bodyS.copyWith(
    color: Get.isDarkMode ? AppColors.darkText : AppColors.blueText,
  );

  static var selectModeTitle = TextStyleBase.h2.copyWith();

  static var registerUserLabelText = TextStyleBase.h5.copyWith();

  static var tmtResultHistoryTabletHeaderText = TextStyleBase.h4;

  static var tmtResultHistoryTabletContentText = TextStyleBase.bodyM;

  //-------------------------reference code Input-------------------------
  static var referenceCodeInputTextStyle = TextStyleBase.bodyL.copyWith(
    color: Colors.white,
  );

  static var referenceCodeHintTextStyle = TextStyleBase.bodyL.copyWith(
    color: Colors.white,
  );

  static var referenceCodeInputErrorTextStyle = TextStyleBase.bodyS.copyWith(
    color: AppColors.mainRed,
  );
}
