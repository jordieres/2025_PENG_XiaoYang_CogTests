import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'theme_mode';
  static const String _systemThemeKey = 'system_theme';

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
    final prefs = await SharedPreferences.getInstance();
    final isSystemTheme = prefs.getBool(_systemThemeKey) ?? true;
    _isFollowSystem.value = isSystemTheme;

    if (isSystemTheme) {
      _themeMode.value = ThemeMode.system;
    } else {
      final themeValue = prefs.getString(_themeKey);
      if (themeValue != null) {
        _themeMode.value = themeValue == ThemeMode.dark.name
            ? ThemeMode.dark
            : ThemeMode.light;
      }
    }
  }

  Future<void> _saveThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_systemThemeKey, _isFollowSystem.value);

    if (!_isFollowSystem.value) {
      await prefs.setString(
          _themeKey,
          _themeMode.value == ThemeMode.dark
              ? ThemeMode.dark.name
              : ThemeMode.light.name);
    }
  }

  void setLightMode() {
    _isFollowSystem.value = false;
    _themeMode.value = ThemeMode.light;
    _saveThemeSettings();
    Get.changeThemeMode(ThemeMode.light);
  }

  void setDarkMode() {
    _isFollowSystem.value = false;
    _themeMode.value = ThemeMode.dark;
    _saveThemeSettings();
    Get.changeThemeMode(ThemeMode.dark);
  }

  void setSystemTheme() {
    _isFollowSystem.value = true;
    _themeMode.value = ThemeMode.system;
    _saveThemeSettings();
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
