// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    contactId: json['contactId'] as int,
    contactFirstName: json['contactFirstName'] as String,
    contactSecondName: json['contactSecondName'] as String,
    contactEmail: json['contactEmail'] as String,
    contactMobile: json['contactMobile'] as String,
    contactAddress: json['contactAddress'] as String,
    authKey: json['authKey'] as String,
    contactActive: json['contactActive'] as bool,
    contactGroup: json['contactGroup'] as String,
  )..contactPassword = json['contactPassword'] as String;
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'contactId': instance.contactId,
      'contactFirstName': instance.contactFirstName,
      'contactSecondName': instance.contactSecondName,
      'contactEmail': instance.contactEmail,
      'contactMobile': instance.contactMobile,
      'contactAddress': instance.contactAddress,
      'authKey': instance.authKey,
      'contactActive': instance.contactActive,
      'contactPassword': instance.contactPassword,
      'contactGroup': instance.contactGroup,
    };
