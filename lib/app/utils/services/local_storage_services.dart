import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  static final LocalStorageServices _localStorageServices =
      LocalStorageServices._internal();

  factory LocalStorageServices() {
    return _localStorageServices;
  }

  static const String _pendingResultsKey = 'pending_tmt_results';
  static const String _themeKey = 'theme_mode';
  static const String _systemThemeKey = 'system_theme';
  static const String _currentProfileKey = 'current_profile_id';

  LocalStorageServices._internal();

  static Future<bool> savePendingResultList(List<String> pendingResults) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(_pendingResultsKey, pendingResults);
  }

  static Future<List<String>> getPendingResultList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_pendingResultsKey) ?? [];
  }

  static Future<bool> clearPendingResultList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_pendingResultsKey);
  }

  static Future<bool> saveThemeSettings(
      bool isFollowSystem, ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_systemThemeKey, isFollowSystem);

    if (!isFollowSystem) {
      await prefs.setString(
          _themeKey,
          themeMode == ThemeMode.dark
              ? ThemeMode.dark.name
              : ThemeMode.light.name);
    }
    return true;
  }

  static Future<Map<String, dynamic>> loadThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isSystemTheme = prefs.getBool(_systemThemeKey) ?? true;

    ThemeMode themeMode = ThemeMode.system;
    if (!isSystemTheme) {
      final themeValue = prefs.getString(_themeKey);
      if (themeValue != null) {
        themeMode = themeValue == ThemeMode.dark.name
            ? ThemeMode.dark
            : ThemeMode.light;
      }
    }
    return {'isFollowSystem': isSystemTheme, 'themeMode': themeMode};
  }

  static Future<bool> setCurrentProfileId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_currentProfileKey, userId);
  }

  static Future<String?> getCurrentProfileId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentProfileKey);
  }

  static Future<bool> clearCurrentProfileId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_currentProfileKey);
  }
}
