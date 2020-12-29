import 'package:json_annotation/json_annotation.dart';

part 'history_model.g.dart';

@JsonSerializable()
class History {
  int auditId;
  String auditDescription;
  DateTime logCreatedTime;
  String actionDoneBy;
  String auditType;

  History(
      {this.auditId,
      this.auditDescription,
      this.logCreatedTime,
      this.actionDoneBy,
      this.auditType});

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}
