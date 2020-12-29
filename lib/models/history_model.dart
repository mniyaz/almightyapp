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

  History.fromJson(Map<String, dynamic> json) {
    auditId = json['auditId'];
    auditDescription = json['auditDescription'];
    logCreatedTime = json['logCreatedTime'];
    actionDoneBy = json['actionDoneBy'];
    auditType = json['auditType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auditId'] = this.auditId;
    data['auditDescription'] = this.auditDescription;
    data['logCreatedTime'] = this.logCreatedTime;
    data['actionDoneBy'] = this.actionDoneBy;
    data['auditType'] = this.auditType;
    return data;
  }
}