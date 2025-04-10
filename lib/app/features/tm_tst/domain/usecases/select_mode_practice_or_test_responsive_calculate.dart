import 'package:flutter/cupertino.dart';

import '../../../../utils/helpers/app_helpers.dart';

class SelectModePracticeOrTestCalculate {

  static final double _defaultCardHeightFactor =
      0.123; // screen height 812, card height 100

  static double calculateCardWidth(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = DeviceHelper.isTablet;

    if (isLandscape) {
      return (screenWidth * 0.8 - 52 - 76) / 2;
    }

    return isTablet
        ? screenWidth * 0.7
        : (isLandscape ? screenWidth * 0.8 : screenWidth);
  }

  static double calculateCardHeight(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;

    if (isLandscape) {
      return screenWidth * getCarHeightHorizontalFactor();
    }
    return screenWidth * getCardHeightVerticalFactor();
  }

  static double getCardHeightVerticalFactor() {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return _defaultCardHeightFactor * 2;
      case DeviceType.mediumTablet:
        return _defaultCardHeightFactor * 2;
      case DeviceType.smallTablet:
        return _defaultCardHeightFactor * 1.5;
      case DeviceType.largePhone:
        return _defaultCardHeightFactor * 3;
      case DeviceType.mediumPhone:
        return _defaultCardHeightFactor * 3;
      case DeviceType.smallPhone:
        return _defaultCardHeightFactor * 3;
    }
  }

  static double getCarHeightHorizontalFactor() {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return _defaultCardHeightFactor * 1;
      case DeviceType.mediumTablet:
        return _defaultCardHeightFactor * 0.8;
      case DeviceType.smallTablet:
        return _defaultCardHeightFactor * 0.9;
      case DeviceType.largePhone:
        return _defaultCardHeightFactor * 0.95;
      case DeviceType.mediumPhone:
        return _defaultCardHeightFactor;
      case DeviceType.smallPhone:
        return _defaultCardHeightFactor * 1.1;
    }
  }
}
