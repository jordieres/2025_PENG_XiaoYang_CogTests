import 'package:flutter/material.dart';
import 'AppColors.dart';

/// all custom application theme
class AppTheme {
  /// default application theme
  static ThemeData get basic => ThemeData(
    primarySwatch: Colors.blue,
  );

  // Light theme
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.getPrimaryBlueColor(),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.getPrimaryBlueColor()),
      titleTextStyle: TextStyle(color: AppColors.mainBlackText),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.getPrimaryBlueColor(),
      secondary: AppColors.secondaryBlue,
      onPrimary: Colors.white,
      onSecondary: AppColors.mainBlackText,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.mainBlackText),
      bodyMedium: TextStyle(color: AppColors.mainBlackText),
      titleLarge: TextStyle(color: AppColors.mainBlackText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.getPrimaryBlueColor(),
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.getPrimaryBlueColor(),
        side: BorderSide(color: AppColors.getPrimaryBlueColor()),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: AppColors.customDialogTitleColor),
      contentTextStyle: TextStyle(color: AppColors.customDialogContentColor),
    ),
    iconTheme: IconThemeData(
      color: AppColors.mainBlackText,
    ),
  );

  // Dark theme
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.getPrimaryBlueDarkColor(),
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.getPrimaryBlueDarkColor()),
      titleTextStyle: TextStyle(color: AppColors.darkText),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.getPrimaryBlueDarkColor(),
      secondary: AppColors.secondaryBlueDark,
      surface: AppColors.darkSurface,
      background: AppColors.darkBackground,
      onPrimary: AppColors.darkText,
      onSecondary: AppColors.darkText,
      onSurface: AppColors.darkText,
      onBackground: AppColors.darkText,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkText),
      titleLarge: TextStyle(color: AppColors.darkText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.getPrimaryBlueDarkColor(),
        foregroundColor: AppColors.darkText,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.getPrimaryBlueDarkColor(),
        side: BorderSide(color: AppColors.getPrimaryBlueDarkColor()),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.darkSurface,
      titleTextStyle: TextStyle(color: AppColors.customDialogTitleColorDark),
      contentTextStyle: TextStyle(color: AppColors.customDialogContentColorDark),
    ),
    cardColor: AppColors.darkSurface,
    iconTheme: IconThemeData(
      color: AppColors.darkText,
    ),
  );
}