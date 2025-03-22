import '../tmt_game_variable.dart';

class MetricStaticValues {
  static const int PAUSE_THRESHOLD_MS = 100; //In ms equal 0.1 seconds
  static const double PAUSE_POSITION_TOLERANCE =
      TmtGameVariables.TOUCH_MARGIN; // 5 pixels

  static const int SEND_METRIC_THRESHOLD_MS = 1000; //In ms equal 1 seconds
}
