import 'package:flutter/cupertino.dart';
import 'package:msdtmt/app/utils/services/app_logger.dart';

import '../../../../utils/helpers/app_helpers.dart';

class RegisterUserScreenResponsiveCalculator {
  static const double kContentTopPadding = 62.0;
  static const double kContentHorizontalPadding = 16.0;
  static const double kContentBottomPadding = 16.0;
  static const double kDefaultSpacing = 42.0;

  static double calculateContainerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final isTablet = DeviceHelper.isTablet;
    if (isLandscape && !isTablet) {
      return screenWidth * 0.7;
    }
    return screenWidth * _calculateContainerWidthScaleFactor();
  }

  static double _calculateContainerWidthScaleFactor() {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return 0.6;
      case DeviceType.mediumTablet:
        return 0.7;
      case DeviceType.smallTablet:
        return 0.8;
      case DeviceType.largePhone:
        return 0.9;
      case DeviceType.mediumPhone:
        return 1.0;
      case DeviceType.smallPhone:
        return 1.0;
    }
  }

  static double calculateSpacingBetweenFormAndButtons(
      BuildContext context, double availableHeight, double formHeight) {
    final remainingSpace = availableHeight -
        formHeight -
        RegisterUserScreenResponsiveCalculator.kContentTopPadding -
        RegisterUserScreenResponsiveCalculator.kContentBottomPadding;

    final result = remainingSpace > 0
        ? remainingSpace / _calculateSpacingBetweenFormAndButtonScaleFactor()
        : RegisterUserScreenResponsiveCalculator.kDefaultSpacing;

    if (result < RegisterUserScreenResponsiveCalculator.kDefaultSpacing) {
      return RegisterUserScreenResponsiveCalculator.kDefaultSpacing;
    }

    AppLogger.debug("fffffff,", "result: $result");
    return result;
  }

  static double _calculateSpacingBetweenFormAndButtonScaleFactor() {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return 4.5;
      case DeviceType.mediumTablet:
        return 3;
      case DeviceType.smallTablet:
        return 3.5;
      case DeviceType.largePhone:
        return 2;
      case DeviceType.mediumPhone:
        return 2;
      case DeviceType.smallPhone:
        return 2;
    }
  }
}
