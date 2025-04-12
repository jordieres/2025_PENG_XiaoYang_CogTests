import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'AppColors.dart';
import 'app_text_style_base.dart';

class CustomInputDecoration {

  static final BorderRadius _defaultBorderRadius = BorderRadius.circular(12);

  static final _BORDER_WIDTH = 2.0;

  static final focusColor =
      Get.isDarkMode ? AppColors.primaryBlueDark : AppColors.primaryBlue;

  static InputDecoration commonInputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: _defaultBorderRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _defaultBorderRadius,
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _defaultBorderRadius,
        borderSide: BorderSide(color: focusColor, width: _BORDER_WIDTH),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: _defaultBorderRadius,
        borderSide: BorderSide(color: AppColors.mainRed, width: _BORDER_WIDTH),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: _defaultBorderRadius,
        borderSide: BorderSide(color: AppColors.mainRed, width: _BORDER_WIDTH),
      ),
      hintStyle: TextStyleBase.bodyM.copyWith(
        color: Color(0xFF8F9098),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }

  static var textInputStyle = TextStyleBase.bodyM.copyWith();

  static var textReadOnlyStyle = TextStyleBase.bodyM.copyWith(
    color: AppColors.mainBlackText.withOpacity(0.5),
  );
}


