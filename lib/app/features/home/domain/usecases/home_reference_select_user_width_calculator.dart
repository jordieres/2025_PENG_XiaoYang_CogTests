import 'package:flutter/material.dart';
import 'package:msdtmt/app/utils/helpers/app_helpers.dart';

class HomeReferenceSelectUserWidthCalculator {
  static double getMaxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    if (isLandscape) {
      return _getLandScapeMaxWidth(screenWidth);
    } else {
      return _getPortraitMaxWidth(screenWidth);
    }
  }

  static double _getLandScapeMaxWidth(double screenWidth) {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return screenWidth * 0.5;
      case DeviceType.mediumTablet:
        return screenWidth * 0.5;
      case DeviceType.smallTablet:
        return screenWidth * 0.5;
      case DeviceType.largePhone:
        return screenWidth * 0.5;
      case DeviceType.mediumPhone:
        return screenWidth * 0.6;
      case DeviceType.smallPhone:
        return screenWidth * 0.9;
    }
  }

  static double _getPortraitMaxWidth(double screenWidth) {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return screenWidth * 0.55;
      case DeviceType.mediumTablet:
        return screenWidth * 0.65;
      case DeviceType.smallTablet:
        return screenWidth * 0.7;
      case DeviceType.largePhone:
        return screenWidth;
      case DeviceType.mediumPhone:
        return screenWidth;
      case DeviceType.smallPhone:
        return screenWidth;
    }
  }
}