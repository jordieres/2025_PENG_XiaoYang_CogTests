import 'dart:math';

import 'package:msdtmt/app/utils/helpers/app_helpers.dart';

class TmtGameVariables {
  static const double _REFERENCE_LINE_STROKE_WIDTH_FACTOR =
      0.136; // Use circle radius 22 , line stroke width 3
  static const double _REFERENCE_CIRCLE_NORMAL_STROKE_WIDTH_FACTOR =
      0.091; // Use circle radius 22 , circle stroke width 2
  static const double _REFERENCE_CIRCLE_ERROR_CORRECT_STROKE_WIDTH_FACTOR =
      0.181; // Use circle radius 22 , circle stroke width 4

  // Percentage of all circles in the screen area
  static const double _CIRCLE_IN_SCREEN_AREA_PERCENTAGE_MOBILE = 0.14;
  static const double _CIRCLE_IN_SCREEN_AREA_PERCENTAGE_TABLET = 0.12;

  static const double TOUCH_MARGIN = 5;
  static const int BOARD_MARGIN = 18;

  static const int DEFAULT_CIRCLE_NUMBER = 25;
  static const int PRACTICE_CIRCLE_NUMBER = 9;

  static int CIRCLE_NUMBER = 25;
  static double circleRadius = 20;

  static double CONNECT_DISTANCE = circleRadius + TOUCH_MARGIN;
  static double safeDistance =
      circleRadius * 2 + TOUCH_MARGIN + BOARD_MARGIN * 2;

  //----------------- Circle Painter Variables -----------------
  static double LINE_STROKE_WIDTH = 3;
  static double CIRCLE_NORMAL_STROKE_WIDTH = 2;
  static double CIRCLE_ERROR_CORRECT_STROKE_WIDTH = 4;
  static double CIRCLE_ERROR_CORRECT_FILL_ALPHA = 0.2;

  static int ERROR_CIRLCLE_APPEAR_DURATION = 500; // ms

  static void setPracticeModeCalculate() {
    CIRCLE_NUMBER = PRACTICE_CIRCLE_NUMBER;
  }

  static void setTestModeCalculate() {
    CIRCLE_NUMBER = 25; //TODO put 25
    //TODO getNUmber circle depend on user preference
  }

  static void calculateTMTGameVariables(double maxWidth, double maxHeight) {
    _calculateOptimizedCircleRadius(maxWidth, maxHeight);

    CONNECT_DISTANCE = circleRadius + TOUCH_MARGIN;
    safeDistance = circleRadius * 2 + TOUCH_MARGIN + BOARD_MARGIN * 2;

    LINE_STROKE_WIDTH = circleRadius * _REFERENCE_LINE_STROKE_WIDTH_FACTOR;

    CIRCLE_NORMAL_STROKE_WIDTH =
        circleRadius * _REFERENCE_CIRCLE_NORMAL_STROKE_WIDTH_FACTOR;

    CIRCLE_ERROR_CORRECT_STROKE_WIDTH =
        circleRadius * _REFERENCE_CIRCLE_ERROR_CORRECT_STROKE_WIDTH_FACTOR;
  }

  static void _calculateOptimizedCircleRadius(
      double maxWidth, double maxHeight) {
    // Calculate available screen area (considering margins)
    double availableWidth = maxWidth - (2 * BOARD_MARGIN);
    double availableHeight = maxHeight - (2 * BOARD_MARGIN);

    double screenArea = availableWidth * availableHeight;

    var areaPercentage = _CIRCLE_IN_SCREEN_AREA_PERCENTAGE_MOBILE;
    if (DeviceHelper.isTablet) {
      areaPercentage = _CIRCLE_IN_SCREEN_AREA_PERCENTAGE_TABLET;
    } else {
      areaPercentage = _CIRCLE_IN_SCREEN_AREA_PERCENTAGE_MOBILE;
    }
    double totalCircleArea = screenArea * areaPercentage;
    double areaPerCircle = totalCircleArea / DEFAULT_CIRCLE_NUMBER;
    double calculatedRadius = sqrt(areaPerCircle / pi);

    circleRadius = calculatedRadius;
  }
}
