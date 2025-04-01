part of app_helpers;

class DoubleHelper {

  static bool roundToTwoDecimals(double value) {
    double roundedValue = double.parse(value.toStringAsFixed(2));
    return value == roundedValue;
  }
}
