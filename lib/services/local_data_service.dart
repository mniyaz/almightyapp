import 'package:almighty/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:almighty/globals.dart' as globals;

import 'dart:convert';

class LocalService {
  static Future<String> _getAuthKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String text = (prefs.getString(globals.AUTH_KEY));
    if (text == null || text == "")
      return "";
    else {
      return text;
    }
  }

  static Future<String> loadAuthKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String text = (prefs.getString(globals.AUTH_KEY));
    if (text == null || text == "")
      return null;
    else {
      return text;
    }
  }

  static Future<String> loadPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String text = (prefs.getString(globals.PASSWORD));
    if (text == null || text == "")
      return null;
    else {
      return text.toString();
    }
  }

  static Future<String> getContactMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String text = (prefs.getString(globals.CONTACT_KEY));
    if (text == null || text == "")
      return "";
    else {
      Contact contact = Contact.fromJson(json.decode(text));
      return contact.contactMobile;
    }
  }

  static Future<Contact> loadContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String text = (prefs.getString(globals.CONTACT_KEY));
    if (text == null || text == "")
      return null;
    else {
      Contact contact = Contact.fromJson(json.decode(text));
      return contact;
    }
  }

  //Incrementing counter after click
  static saveAPIData(String key, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }
}
