import '../tmt_game_variable.dart';

class MetricStaticValues {
  static const int PAUSE_THRESHOLD_MS = 100; //In ms equal 0.1 seconds
  static const double PAUSE_POSITION_TOLERANCE =
      TmtGameVariables.TOUCH_MARGIN; // 5 pixels

  static const int SEND_METRIC_THRESHOLD_MS = 1000; //In ms equal 1 seconds

  static const int SECTION_1_END = 5;
  static const int SECTION_2_END = 10;
  static const int SECTION_3_END = 15;
  static const int SECTION_4_END = 20;
  static const int SECTION_5_END = 25;

  static const double NOT_SECTION_4_AND_5 = -1.0;
}
