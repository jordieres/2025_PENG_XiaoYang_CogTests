part of app_helpers;

class DoubleHelper {
  static double roundToTwoDecimals(double value) {
    return (value * 100).round() / 100;
  }
}
