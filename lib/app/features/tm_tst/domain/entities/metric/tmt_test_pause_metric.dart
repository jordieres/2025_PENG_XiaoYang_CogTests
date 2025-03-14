import 'metric_static_values.dart';

class TmtTestPauseMetric {
  int numberPause = 0;
  int totalPauseTime = 0;
  late DateTime lastPauseTime;

  double calculateAveragePause() {
    return numberPause > 0 ? totalPauseTime / numberPause : 0;
  }

  void onStartPause() {
    lastPauseTime = DateTime.now();
  }

  void onEndPause() {
    DateTime now = DateTime.now();
    if (now.difference(lastPauseTime).inMilliseconds >=
        MetricStaticValues.DEFAULT_PAUSE_TIME) {
      totalPauseTime += now.difference(lastPauseTime).inMilliseconds;
      numberPause++;
    }
  }
}
