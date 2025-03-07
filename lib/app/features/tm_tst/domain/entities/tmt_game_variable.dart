class TmtGameVariables {
  static int CIRCLE_NUMBER = 25;
  static double TOUCH_MARGIN = 5;
  static int BOARD_MARGIN = 10;
  static double circleRadius = 20;
  static double CONNECT_DISTANCE = circleRadius + TOUCH_MARGIN;
  static double safeDistance =
      circleRadius * 2 + TOUCH_MARGIN + BOARD_MARGIN * 2;

  static double LINE_STROKE_WIDTH = 3;
  static double CIRCLE_NORMAL_STROKE_WIDTH = 2;
  static double CIRCLE_ERROR_CORRECT_STROKE_WIDTH = 4;
  static double CIRCLE_ERROR_CORRECT_FILL_ALPHA = 0.2;

  static int ERROR_CIRLCLE_APPEAR_DURATION = 500; // ms
}
