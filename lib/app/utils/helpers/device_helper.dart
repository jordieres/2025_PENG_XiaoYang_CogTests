part of app_helpers;

enum DeviceType {
  largeTablet,
  mediumTablet,
  smallTablet,
  largePhone,
  mediumPhone,
  smallPhone
}

class DeviceHelper {
  static const Map<DeviceType, int> _deviceSizeMap = {
    // Tablet
    DeviceType.largeTablet: 1000,
    //  largeTablet (iPad Pro 12.9", Galaxy Tab S7)
    DeviceType.mediumTablet: 800,
    //  mediumTablet (iPad Pro 11", iPad Air)
    DeviceType.smallTablet: 550,
    //  smallTablet (iPad Mini, Galaxy Tab A)

    // MOBILE
    DeviceType.largePhone: 400,
    // largePhone (iPhone Pro Max, Galaxy Note)
    DeviceType.mediumPhone: 350,
    // mediumPhone (iPhone , Galaxy S)
    DeviceType.smallPhone: 300,
    // smallPhone (iPhone SE, small Android phones)
  };

  static bool isTablet = false;
  static DeviceType deviceType = DeviceType.mediumPhone;

  static void init(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    isTablet = _calculateIsTablet(shortestSide);
    deviceType = getDeviceType(shortestSide);
  }

  static void calculateAgain(BuildContext context) {
    init(context);
  }

  static bool _calculateIsTablet(double shortestSide) {
    return shortestSide >= 600;
  }

  static DeviceType getDeviceType(double shortestSide) {
    if (shortestSide >= _deviceSizeMap[DeviceType.largeTablet]!) {
      return DeviceType.largeTablet;
    } else if (shortestSide >= _deviceSizeMap[DeviceType.mediumTablet]!) {
      return DeviceType.mediumTablet;
    } else if (shortestSide >= _deviceSizeMap[DeviceType.smallTablet]!) {
      return DeviceType.smallTablet;
    } else if (shortestSide >= _deviceSizeMap[DeviceType.largePhone]!) {
      return DeviceType.largePhone;
    } else if (shortestSide >= _deviceSizeMap[DeviceType.mediumPhone]!) {
      return DeviceType.mediumPhone;
    } else if (shortestSide >= _deviceSizeMap[DeviceType.smallPhone]!) {
      return DeviceType.smallPhone;
    } else {
      return DeviceType.mediumPhone;
    }
  }
}
