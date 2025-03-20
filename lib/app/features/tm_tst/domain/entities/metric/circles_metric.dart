class CirclesMetric {
  double distance = 0;
  int duration = 0; // In milliseconds

  CirclesMetric copy() {
    CirclesMetric metric = CirclesMetric();
    metric.distance = distance;
    metric.duration = duration;
    return metric;
  }
}
