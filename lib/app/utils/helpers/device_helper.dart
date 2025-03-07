part of app_helpers;

class DeviceHelper {
  static bool isTablet = false;

  void init(BuildContext context) {
    isTablet = _calculateIsTablet(context);
    print("isTablet: $isTablet");
  }

  bool _calculateIsTablet(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 600;
  }
}
