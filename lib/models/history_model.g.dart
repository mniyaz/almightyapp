// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) {
  return History(
    auditId: json['auditId'] as int,
    auditDescription: json['auditDescription'] as String,
    logCreatedTime: json['logCreatedTime'] == null
        ? null
        : DateTime.parse(json['logCreatedTime'] as String),
    actionDoneBy: json['actionDoneBy'] as String,
    auditType: json['auditType'] as String,
  );
}

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'auditId': instance.auditId,
      'auditDescription': instance.auditDescription,
      'logCreatedTime': instance.logCreatedTime?.toIso8601String(),
      'actionDoneBy': instance.actionDoneBy,
      'auditType': instance.auditType,
    };
