import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class Contact extends ChangeNotifier{
  int contactId;
  String contactFirstName;
  String contactSecondName;
  String contactEmail;
  String contactMobile;
  String contactAddress;
  String authKey;
  bool contactActive;
  String contactPassword;
  String contactGroup;

  Contact(
      {this.contactId,
        this.contactFirstName,
        this.contactSecondName,
        this.contactEmail,
        this.contactMobile,
        this.contactAddress,
        this.authKey,
        this.contactActive,
        this.contactGroup});

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}