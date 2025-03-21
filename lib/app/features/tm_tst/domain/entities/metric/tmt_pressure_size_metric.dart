class TmtPressureSizeMetric {
  static const noHavePressureCharacteristic =
      1; // if device don't have pressure characteristic
  static const noHaveSizeCharacteristic =
      0; // if device don't have size characteristic

  static const noHavePressureORSizeCharacteristicValue =
      -1; // if device don't have pressure and size characteristic will send -1

  final List<double> _pressureList = [];
  final List<double> _sizeList = [];

  TmtPressureSizeMetric copy() {
    TmtPressureSizeMetric metric = TmtPressureSizeMetric();
    metric._pressureList.addAll(_pressureList);
    metric._sizeList.addAll(_sizeList);
    return metric;
  }

  void addPressureValue(double pressure) {
    if (pressure > 0) {
      _pressureList.add(pressure);
    }
  }

  void addSizeValue(double size) {
    if (size > 0) {
      _sizeList.add(size);
    }
  }

  /// Total Average Pressure: Average pressure values based on how hard the user is pressing
  /// on the screen using the surface area of the pressed stylus.
  double calculateAverageTotalPressure() {
    if (_pressureList.isEmpty) return 0;
    final totalPressure = _pressureList.reduce((a, b) => a + b);
    return totalPressure / _pressureList.length;
  }

  /// Total Average Size: Average size values based on how hard the user is pressing
  /// on the screen using the surface area of the pressed stylus.
  double calculateAverageTotalSize() {
    if (_sizeList.isEmpty) return 0;
    final totalSize = _sizeList.reduce((a, b) => a + b);
    return totalSize / _sizeList.length;
  }
}
