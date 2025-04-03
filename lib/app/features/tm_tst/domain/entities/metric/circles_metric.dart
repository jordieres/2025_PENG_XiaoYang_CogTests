import 'package:msdtmt/app/utils/helpers/app_helpers.dart';

class CirclesMetric {
  double _distance = 0;
  double get distance => _distance;

  int duration = 0; // In milliseconds

  CirclesMetric copy() {
    CirclesMetric metric = CirclesMetric();
    metric._distance = _distance;
    metric.duration = duration;
    return metric;
  }

  /// Distance of offset is DP of the device
  /// But the distance is calculated in pixels
  void setRealDistance(double distance) {
    _distance = distance * DeviceHelper.devicePixelRatio;
  }
}
