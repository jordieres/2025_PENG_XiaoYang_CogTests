import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'app_text_style_base.dart';

class CustomInputDecoration {
  static final BorderRadius _defaultBorderRadius = BorderRadius.circular(12);

  static InputDecoration commonInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: _defaultBorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: _defaultBorderRadius,
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: _defaultBorderRadius,
      borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: _defaultBorderRadius,
      borderSide: BorderSide(color: AppColors.mainRed, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: _defaultBorderRadius,
      borderSide: BorderSide(color: AppColors.mainRed, width: 2),
    ),
    hintStyle: TextStyleBase.bodyM.copyWith(
      color: Color(0xFF8F9098),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  );

  static var textInputStyle = TextStyleBase.bodyM.copyWith(
  );
}
