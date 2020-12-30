import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static Object getData(String keyName) async {
    final prefs = await SharedPreferences.getInstance();
    final key = keyName;
    final value = prefs.getInt(key) ?? 0;
    return value;
  }

  static void saveData(String newKey, Object newValue) async {
    final prefs = await SharedPreferences.getInstance();
    final key = newKey;
    final value = newValue;
    prefs.setInt(key, value);
  }
}