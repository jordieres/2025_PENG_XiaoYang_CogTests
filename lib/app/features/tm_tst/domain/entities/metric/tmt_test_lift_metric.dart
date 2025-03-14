import 'metric_static_values.dart';

class TmtTestLiftMetric {
  int numberLift = 0;
  int totalLiftTime = 0;
  DateTime? _lastPauseTime;

  double calculateAverageLift() {
    return numberLift > 0 ? totalLiftTime / numberLift : 0;
  }

  void onStartLift() {
    _lastPauseTime = DateTime.now();
  }

  void onEndLift() {
    if (_lastPauseTime == null) {
      return;
    }
    DateTime now = DateTime.now();
    totalLiftTime += now.difference(_lastPauseTime!).inMilliseconds;
    numberLift++;
  }
}
