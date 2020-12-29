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

  Contact.fromJson(Map<String, dynamic> json) {
    contactId = json['contactId'];
    contactFirstName = json['contactFirstName'];
    contactMobile = json['contactMobile'];
    authKey = json['authKey'];
    contactActive = json['contactActive'];
    contactGroup = json['contactGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactId'] = this.contactId;
    data['contactFirstName'] = this.contactFirstName;
    data['contactMobile'] = this.contactMobile;
    data['authKey'] = this.authKey;
    data['contactActive'] = this.contactActive;
    data['contactGroup'] = this.contactGroup;
    return data;
  }
}