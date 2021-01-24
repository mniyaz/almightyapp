import 'package:almighty/models/contact_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:almighty/globals.dart' as globals;

import 'dart:convert';

class LocalService {
  static Future<String> getMobile(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/' + fileName + '.txt');
      String text = await file.readAsString();
      Contact contact = Contact.fromJson(json.decode(text));
      return contact.contactMobile;
    } catch (e) {
      print("Couldn't read file");
    }
  }

  static Future<String> getAuthKey(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/' + fileName + '.txt');
      String text = await file.readAsString();
      return text;
    } catch (e) {
      print("Couldn't read file");
    }
  }

  static Future<Contact> getContact(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/' + fileName + '.txt');
      String text = await file.readAsString();
      Contact contact = Contact.fromJson(json.decode(text));
      return contact;
    } catch (e) {
      print("Couldn't read file");
    }
  }

  static Future<Null> saveData(String fileName, String value) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/' + fileName + '.txt');
    final text = value;
    await file.writeAsString(text);
  }

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
