import 'package:almighty/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static Object getData(String keyName) async {
    final prefs = await SharedPreferences.getInstance();
    final key = keyName;
    final value = prefs.getInt(key) ?? 0;
    return value;
  }

  static Future<String> getMobile(String keyName) async {
    final prefs = await SharedPreferences.getInstance();
    final key = keyName;
    final value = prefs.getString(key) ?? 0;
    return value;
  }

  static Future<String> getAuthKey(String keyName) async {
    final prefs = await SharedPreferences.getInstance();
    final key = keyName;
    final value = prefs.getString(key) ?? 0;
    return value;
  }

  static Future<Contact> getContact(String keyName) async {
    final prefs = await SharedPreferences.getInstance();
    final key = keyName;
    final value = prefs.get(key) ?? null;
    if(value is Contact){
      Contact contact = value;
      return contact;
    }else{
      return null;
    }
  }

  static void saveData(String newKey, Object newValue) async {
    final prefs = await SharedPreferences.getInstance();
    final key = newKey;
    final value = newValue;
    prefs.setInt(key, value);
  }
}