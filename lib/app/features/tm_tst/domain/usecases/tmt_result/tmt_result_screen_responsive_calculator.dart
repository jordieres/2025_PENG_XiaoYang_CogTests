import 'package:flutter/material.dart';
import '../../../../../constans/app_constants.dart';
import '../../../../../utils/helpers/app_helpers.dart';

class TmtResultResponsiveCalculator {
  static double getScaleFactor() {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return 1.6;
      case DeviceType.mediumTablet:
        return 1.3;
      case DeviceType.smallTablet:
        return 1.2;
      case DeviceType.largePhone:
        return 1.0;
      case DeviceType.mediumPhone:
        return 1.0;
      case DeviceType.smallPhone:
        return 0.9;
    }
  }

  static ResultLayoutMetrics calculateLayoutMetrics(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = DeviceHelper.isTablet;

    final double baseScaleFactor = getScaleFactor();
    final responsiveRatio = screenHeight / AppDesignSize.designHeight;

    return ResultLayoutMetrics(
        topMargin: isLandscape
            ? 30 * responsiveRatio * baseScaleFactor
            : 40 * responsiveRatio * baseScaleFactor,
        titleToSessionsMargin: isLandscape
            ? 30 * responsiveRatio * baseScaleFactor
            : 40 * responsiveRatio * baseScaleFactor,
        sessionsToCardMargin: 28 * responsiveRatio * baseScaleFactor,
        betweenCardsMargin: 28 * responsiveRatio * baseScaleFactor,
        cardsToThanksTextMargin: isLandscape
            ? 58 * responsiveRatio * baseScaleFactor
            : 40 * responsiveRatio * baseScaleFactor,
        tanksTextToButtonMargin: isLandscape
            ? 28 * responsiveRatio * baseScaleFactor
            : 38 * responsiveRatio * baseScaleFactor,
        horizontalCardSpacing:
            16 * (screenWidth / AppDesignSize.designWidth) * baseScaleFactor,
        bottomMargin: isLandscape
            ? 50 * responsiveRatio * baseScaleFactor
            : 40 * responsiveRatio * baseScaleFactor,
        contentMaxWidth:
            (isTablet && isLandscape) ? screenWidth * 0.7 : double.infinity,
        cardContainerWidth:
            isTablet && !isLandscape ? screenWidth * 0.8 : double.infinity,
        isLandscape: isLandscape,
        isTablet: isTablet,
        screenWidth: screenWidth,
        horizontalPadding: (isTablet && isLandscape) ? 0 : screenWidth * 0.04);
  }

  static bool shouldShowScrollIndicator({
    required RenderBox contentBox,
    required double screenHeight,
  }) {
    final contentHeight = contentBox.size.height;
    return contentHeight > screenHeight;
  }

  static CardHeightProportions calculateCardHeightProportions(
      double cardHeight) {
    final baseSpacing = cardHeight * 0.685;
    return CardHeightProportions(
      cardsToTextMargin:
          DeviceHelper.isTablet ? baseSpacing * 0.55 : baseSpacing * 0.6, //
      textToButtonMargin: baseSpacing * 0.4, // 40%  textToButtonMargin
    );
  }
}

class ResultLayoutMetrics {
  final double topMargin;
  final double titleToSessionsMargin;
  final double sessionsToCardMargin;
  final double betweenCardsMargin;
  final double cardsToThanksTextMargin;
  final double tanksTextToButtonMargin;
  final double horizontalCardSpacing;
  final double bottomMargin;
  final double contentMaxWidth;
  final double cardContainerWidth;
  final bool isLandscape;
  final bool isTablet;
  final double screenWidth;
  final double horizontalPadding;

  ResultLayoutMetrics({
    required this.topMargin,
    required this.titleToSessionsMargin,
    required this.sessionsToCardMargin,
    required this.betweenCardsMargin,
    required this.cardsToThanksTextMargin,
    required this.tanksTextToButtonMargin,
    required this.horizontalCardSpacing,
    required this.bottomMargin,
    required this.contentMaxWidth,
    required this.cardContainerWidth,
    required this.isLandscape,
    required this.isTablet,
    required this.screenWidth,
    required this.horizontalPadding,
  });
}

class CardHeightProportions {
  final double cardsToTextMargin;
  final double textToButtonMargin;

  CardHeightProportions({
    required this.cardsToTextMargin,
    required this.textToButtonMargin,
  });
}
