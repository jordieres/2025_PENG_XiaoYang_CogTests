import 'package:shared_preferences/shared_preferences.dart';

/// contains all service to get data from local
class LocalStorageServices {
  static final LocalStorageServices _localStorageServices =
      LocalStorageServices._internal();

  factory LocalStorageServices() {
    return _localStorageServices;
  }

  static const String _pendingResultsKey = 'pending_tmt_results';

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
}
