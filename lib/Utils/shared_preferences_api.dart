import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesApi {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static void setString(String key, String value) =>
      _instance?.setString(key, value);

  static void setBool(String key, bool value) => _instance?.setBool(key, value);

  static void setInt(String key, int value) => _instance?.setInt(key, value);

  static void setDouble(String key, double value) =>
      _instance?.setDouble(key, value);

  static String? getString(String key) => _instance?.getString(key);

  static bool? getBool(String key) => _instance?.getBool(key);

  static int? getInt(String key) => _instance?.getInt(key);

  static double? getDouble(String key) => _instance?.getDouble(key);
}
