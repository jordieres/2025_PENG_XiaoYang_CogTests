
import 'package:flutter/material.dart';
import '../../utils/helpers/app_helpers.dart';
import 'AppFontWeight.dart';

class TextStyleBase{

  static const double tabletScaleFactor = 1.2;

  //Heading mobile size
  static const double _h1Size = 24.0;
  static const double _h2Size = 18.0;
  static const double _h3Size = 16.0;
  static const double _h4Size = 14.0;
  static const double _h5Size = 12.0;

  //Body mobile size
  static const double _bodyXLSize = 18.0;
  static const double _bodyLSize = 16.0;
  static const double _bodyMSize = 14.0;
  static const double _bodySSize = 12.0;
  static const double _bodyXSSize = 10.0;

  // Action mobile size
  static const double _actionLSize = 14.0;
  static const double _actionMSize = 12.0;
  static const double _actionSSize = 10.0;

  // Caption mobile size
  static const double _captionMSize = 10.0;

  //Heading
  static double get h1Size =>
      DeviceHelper.isTablet ? _h1Size * tabletScaleFactor : _h1Size;

  static double get h2Size =>
      DeviceHelper.isTablet ? _h2Size * tabletScaleFactor : _h2Size;

  static double get h3Size =>
      DeviceHelper.isTablet ? _h3Size * tabletScaleFactor : _h3Size;

  static double get h4Size =>
      DeviceHelper.isTablet ? _h4Size * tabletScaleFactor : _h4Size;

  static double get h5Size =>
      DeviceHelper.isTablet ? _h5Size * tabletScaleFactor : _h5Size;

  //Body
  static double get bodyXLSize =>
      DeviceHelper.isTablet ? _bodyXLSize * tabletScaleFactor : _bodyXLSize;

  static double get bodyLSize =>
      DeviceHelper.isTablet ? _bodyLSize * tabletScaleFactor : _bodyLSize;

  static double get bodyMSize =>
      DeviceHelper.isTablet ? _bodyMSize * tabletScaleFactor : _bodyMSize;

  static double get bodySSize =>
      DeviceHelper.isTablet ? _bodySSize * tabletScaleFactor : _bodySSize;

  static double get bodyXSSize =>
      DeviceHelper.isTablet ? _bodyXSSize * tabletScaleFactor : _bodyXSSize;

  //Action
  static double get actionLSize =>
      DeviceHelper.isTablet ? _actionLSize * tabletScaleFactor : _actionLSize;

  static double get actionMSize =>
      DeviceHelper.isTablet ? _actionMSize * tabletScaleFactor : _actionMSize;

  static double get actionSSize =>
      DeviceHelper.isTablet ? _actionSSize * tabletScaleFactor : _actionSSize;

  //Caption
  static double get captionMSize =>
      DeviceHelper.isTablet ? _captionMSize * tabletScaleFactor : _captionMSize;


  // Heading
  static TextStyle get h1 => TextStyle(
    fontSize: h1Size,
    fontWeight: AppFontWeight.extraBold,
  );

  static TextStyle get h2 => TextStyle(
    fontSize: h2Size,
    fontWeight: AppFontWeight.extraBold,
  );

  static TextStyle get h3 => TextStyle(
    fontSize: h3Size,
    fontWeight: AppFontWeight.extraBold,
  );

  static TextStyle get h4 => TextStyle(
    fontSize: h4Size,
    fontWeight: AppFontWeight.bold,
  );


  static TextStyle get h5 => TextStyle(
    fontSize: h5Size,
    fontWeight: AppFontWeight.bold,
  );

  //Body
  static TextStyle get bodyXL => TextStyle(
    fontSize: bodyXLSize,
    fontWeight: AppFontWeight.normal,
  );

  static TextStyle get bodyL => TextStyle(
    fontSize: bodyLSize,
    fontWeight: AppFontWeight.normal,
  );

  static TextStyle get bodyM => TextStyle(
    fontSize: bodyMSize,
    fontWeight: AppFontWeight.normal,
  );

  static TextStyle get bodyS => TextStyle(
    fontSize: bodySSize,
    fontWeight: AppFontWeight.normal,
  );

  static TextStyle get bodyXS => TextStyle(
    fontSize: bodyXSSize,
    fontWeight: AppFontWeight.medium,
  );

  // Action
  static TextStyle get actionL => TextStyle(
    fontSize: actionLSize,
    fontWeight: AppFontWeight.semiBold,
  );

  static TextStyle get actionM => TextStyle(
    fontSize: actionMSize,
    fontWeight: AppFontWeight.semiBold,
  );

  static TextStyle get actionS => TextStyle(
    fontSize: actionSSize,
    fontWeight: AppFontWeight.semiBold,
  );

  // Caption
  static TextStyle get captionM => TextStyle(
    fontSize: captionMSize,
    fontWeight: AppFontWeight.semiBold,
  );

}