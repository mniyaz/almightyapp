import 'package:almighty/models/contact_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
}
