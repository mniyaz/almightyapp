// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    contactId: json['contactId'] as int,
    contactFirstName: json['contactFirstName'] as String,
    contactMobile: json['contactMobile'] as String,
    authKey: json['authKey'] as String,
    contactActive: json['contactActive'] as bool,
    contactGroup: json['contactGroup'] as String,
  );
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'contactId': instance.contactId,
      'contactFirstName': instance.contactFirstName,
      'contactMobile': instance.contactMobile,
      'authKey': instance.authKey,
      'contactActive': instance.contactActive,
      'contactGroup': instance.contactGroup,
    };
