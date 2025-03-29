import 'package:flutter/material.dart';
import '../../../../../utils/helpers/app_helpers.dart';

/// Class responsible for performing all responsive calculations for the TmtResultCard component
class TmtResultCardResponsiveCalculator {
  static double getScaleFactor() {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return 1.5;
      case DeviceType.mediumTablet:
        return 1.4;
      case DeviceType.smallTablet:
        return 1.3;
      case DeviceType.largePhone:
        return 1.0;
      case DeviceType.mediumPhone:
        return 0.9;
      case DeviceType.smallPhone:
        return 0.8;
    }
  }

  /// Calculates design metrics for the TmtResultCard component
  static TmtResultCardMetrics calculateCardMetrics(BuildContext context) {
    final scaleFactor = getScaleFactor();
    final isTablet = DeviceHelper.isTablet;
    final screenWidth = MediaQuery.of(context).size.width;

    final maxCardWidth = isTablet ? screenWidth * 0.7 : double.infinity;

    // Apply scale factor to margins and spaces
    final verticalMargin = 8.0 * scaleFactor;
    final topPadding = 16.0 * scaleFactor;
    final titleSpacing = 24.0 * scaleFactor;
    final bottomPadding = 16.0 * scaleFactor;
    final labelValueSpacing = 8.0 * scaleFactor;
    final borderRadius = DeviceHelper.isTablet ? 15.0 : 10.0;

    return TmtResultCardMetrics(
      maxCardWidth: maxCardWidth,
      verticalMargin: verticalMargin,
      topPadding: topPadding,
      titleSpacing: titleSpacing,
      bottomPadding: bottomPadding,
      labelValueSpacing: labelValueSpacing,
      borderRadius: borderRadius,
      scaleFactor: scaleFactor,
      isTablet: isTablet,
    );
  }

  static TmtResultCardLayoutSpacing calculateLayoutSpacing(
      BuildContext context,
      BoxConstraints constraints,
      double durationTextWidth,
      double errorsTextWidth,
      ) {
    // Calculate the width of texts plus a margin for values
    final durationWidth = durationTextWidth + 20; // +20 for the value
    final errorsWidth = errorsTextWidth + 20; // +20 for the value

    // Available space = total width - (width of texts + values)
    final availableSpace = constraints.maxWidth - (durationWidth + errorsWidth);

    // Ensure that availableSpace is not negative
    final safeAvailableSpace = availableSpace > 0 ? availableSpace : 0;

    // Divide the available space into 5 parts
    final spacePart = safeAvailableSpace / 5;

    // Assign 2 parts for left and right padding
    final padding = spacePart * 2;

    return TmtResultCardLayoutSpacing(
      leftPadding: padding,
      rightPadding: padding,
    );
  }

  static double calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width;
  }
}

class TmtResultCardMetrics {
  final double maxCardWidth;
  final double verticalMargin;
  final double topPadding;
  final double titleSpacing;
  final double bottomPadding;
  final double labelValueSpacing;
  final double borderRadius;
  final double scaleFactor;
  final bool isTablet;

  TmtResultCardMetrics({
    required this.maxCardWidth,
    required this.verticalMargin,
    required this.topPadding,
    required this.titleSpacing,
    required this.bottomPadding,
    required this.labelValueSpacing,
    required this.borderRadius,
    required this.scaleFactor,
    required this.isTablet,
  });
}

class TmtResultCardLayoutSpacing {
  final double leftPadding;
  final double rightPadding;

  TmtResultCardLayoutSpacing({
    required this.leftPadding,
    required this.rightPadding,
  });
}