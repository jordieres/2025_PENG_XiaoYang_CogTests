import 'metric_static_values.dart';

class TmtTestPauseMetric {
  int numberPause = 0;
  int totalPauseTime = 0;
  DateTime? _lastPauseTime;

  double calculateAveragePause() {
    return numberPause > 0 ? totalPauseTime / numberPause : 0;
  }

  void onStartPause() {
    _lastPauseTime = DateTime.now();
  }

  void onEndPause() {

  }
}
