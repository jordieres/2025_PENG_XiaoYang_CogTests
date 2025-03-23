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
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryBlue),
      titleTextStyle: TextStyle(color: AppColors.mainBlackText),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
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
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: BorderSide(color: AppColors.primaryBlue),
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
    primaryColor: AppColors.primaryBlueDark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryBlueDark),
      titleTextStyle: TextStyle(color: AppColors.darkText),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryBlueDark,
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
        backgroundColor: AppColors.primaryBlueDark,
        foregroundColor: AppColors.darkText,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlueDark,
        side: BorderSide(color: AppColors.primaryBlueDark),
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