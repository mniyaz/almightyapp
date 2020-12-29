import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class Contact {
  int contactId;
  String contactFirstName;
  String contactMobile;
  String authKey;
  bool contactActive;
  String contactGroup;

  Contact(
      {this.contactId,
        this.contactFirstName,
        this.contactMobile,
        this.authKey,
        this.contactActive,
        this.contactGroup});

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}