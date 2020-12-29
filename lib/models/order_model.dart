import 'items_model.dart';
import 'contact_model.dart';
import 'history_model.dart';
class Order {
  int orderId;
  DateTime orderCreatedTime;
  String totalPriceBeforeTax;
  int cGSTPercentage;
  int sGSTPercentage;
  int iGSTPercentage;
  String grandTotal;
  String orderStatus;
  String tmpOrderId;
  bool paid;
  List<Items> items;
  List<History> history;
  Contact contact;

  Order(
      {this.orderId,
        this.orderCreatedTime,
        this.totalPriceBeforeTax,
        this.cGSTPercentage,
        this.sGSTPercentage,
        this.iGSTPercentage,
        this.grandTotal,
        this.orderStatus,
        this.tmpOrderId,
        this.paid,
        this.items,
        this.history,
        this.contact});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderCreatedTime = json['orderCreatedTime'];
    totalPriceBeforeTax = json['totalPriceBeforeTax'];
    cGSTPercentage = json['CGSTPercentage'];
    sGSTPercentage = json['SGSTPercentage'];
    iGSTPercentage = json['IGSTPercentage'];
    grandTotal = json['GrandTotal'];
    orderStatus = json['orderStatus'];
    tmpOrderId = json['tmpOrderId'];
    paid = json['paid'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    if (json['history'] != null) {
      history = new List<History>();
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderCreatedTime'] = this.orderCreatedTime;
    data['totalPriceBeforeTax'] = this.totalPriceBeforeTax;
    data['CGSTPercentage'] = this.cGSTPercentage;
    data['SGSTPercentage'] = this.sGSTPercentage;
    data['IGSTPercentage'] = this.iGSTPercentage;
    data['GrandTotal'] = this.grandTotal;
    data['orderStatus'] = this.orderStatus;
    data['tmpOrderId'] = this.tmpOrderId;
    data['paid'] = this.paid;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    if (this.contact != null) {
      data['contact'] = this.contact.toJson();
    }
    return data;
  }
}