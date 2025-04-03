import 'metric_static_values.dart';

class TmtTestLiftMetric {
  int numberLift = 0;
  int totalLiftTime = 0;
  DateTime? _lastPauseTime;

  TmtTestLiftMetric copy() {
    TmtTestLiftMetric metric = TmtTestLiftMetric();
    metric.numberLift = numberLift;
    metric.totalLiftTime = totalLiftTime;

    if (_lastPauseTime != null) {
      metric._lastPauseTime = DateTime.fromMillisecondsSinceEpoch(
          _lastPauseTime!.millisecondsSinceEpoch);
    }

    return metric;
  }

  double calculateAverageLift() {
    return numberLift > 0
        ? (totalLiftTime / MetricStaticValues.SEND_METRIC_THRESHOLD_MS) /
            numberLift
        : 0;
  }

  void onStartLift() {
    _lastPauseTime = DateTime.now();
  }

  void onEndLift() {
    if (_lastPauseTime == null) {
      return;
    }
    DateTime now = DateTime.now();
    totalLiftTime += now.difference(_lastPauseTime!).abs().inMilliseconds;
    numberLift++;
  }
}
