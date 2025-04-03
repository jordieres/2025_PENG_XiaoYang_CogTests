import 'dart:ui';

class AppColors {
  // Light mode colors
  static const Color primaryBlue = Color(0xFF3086CF); // Main blue color
  static const Color secondaryBlue = Color(0xFFE8F1FA); // Secondary blue color
  static const Color mainBlackText = Color(0xFF222222); // Main black text color
  static const Color blueText = Color(0xFF0E47A1); // Blue text color
  static const Color mainRed = Color(0xFFD74343); // Red color

  // Dark mode colors
  static const Color primaryBlueDark = Color(0xFF2375BC); // Darker blue color
  static const Color secondaryBlueDark = Color(0xFF1A3A5A); // Darker secondary blue
  static const Color darkBackground = Color(0xFF121212); // Dark background
  static const Color darkSurface = Color(0xFF1E1E1E); // Dark surface color
  static const Color darkText = Color(0xFFFFFFFF); // Dark mode text color

  // Test TMT Colors - Light Mode
  static const Color testTMTBoardBackground = Color(0xFFE7E7E7); // Test TMT Background
  static const Color testTMTNormalLine = mainBlackText; // Test TMT Normal Circle Color
  static const Color testTMTNormalCircleFill = Color(0xFFFFFFFF); // Test TMT Normal Circle Fill
  static const Color testTMTCurrentCircleStroke = Color(0xFFDCD74D); // Test TMT Current Circle Color
  static const Color testTMTCorrectCircleStroke = Color(0xFF03BA03); // Green correct color (TMT)
  static const Color testTMTIncorrectCircleStroke = mainRed; // Red incorrect color (TMT)

  // Test TMT Colors - Dark Mode
  static const Color testTMTBoardBackgroundDark = Color(0xFF2C2C2C); // Dark Test TMT Background
  static const Color testTMTNormalLineDark = darkText; // Dark Test TMT Normal Circle Color
  static const Color testTMTNormalCircleFillDark = Color(0xFF3C3C3C); // Dark Test TMT Normal Circle Fill

  // Dialog Colors - Light Mode
  static const Color customDialogTitleColor = mainBlackText;
  static const Color customDialogContentColor = Color(0xFF71727A);
  static const Color customButtonColor = primaryBlue;

  // Dialog Colors - Dark Mode
  static const Color customDialogTitleColorDark = darkText;
  static const Color customDialogContentColorDark = Color(0xFFB0B0B0);
  static const Color customButtonColorDark = primaryBlueDark;
}