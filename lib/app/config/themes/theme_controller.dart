import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/services/local_storage_services.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  final RxBool _isFollowSystem = true.obs;

  ThemeMode get themeMode => _themeMode.value;

  bool get isFollowSystem => _isFollowSystem.value;

  bool get isDarkMode =>
      _themeMode.value == ThemeMode.dark ||
          (_themeMode.value == ThemeMode.system && Get.isPlatformDarkMode);

  @override
  void onInit() {
    super.onInit();
    _loadThemeSettings();
  }

  Future<void> _loadThemeSettings() async {
    final themeSettings = await LocalStorageServices.loadThemeSettings();
    _isFollowSystem.value = themeSettings['isFollowSystem'];
    _themeMode.value = themeSettings['themeMode'];
  }

  Future<void> setLightMode() async {
    _isFollowSystem.value = false;
    _themeMode.value = ThemeMode.light;
    await LocalStorageServices.saveThemeSettings(_isFollowSystem.value, _themeMode.value);
    Get.changeThemeMode(ThemeMode.light);
  }

  Future<void> setDarkMode() async {
    _isFollowSystem.value = false;
    _themeMode.value = ThemeMode.dark;
    await LocalStorageServices.saveThemeSettings(_isFollowSystem.value, _themeMode.value);
    Get.changeThemeMode(ThemeMode.dark);
  }

  Future<void> setSystemTheme() async {
    _isFollowSystem.value = true;
    _themeMode.value = ThemeMode.system;
    await LocalStorageServices.saveThemeSettings(_isFollowSystem.value, _themeMode.value);
    Get.changeThemeMode(ThemeMode.system);
  }

  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      setDarkMode();
    } else {
      setLightMode();
    }
  }
}