import 'package:json_annotation/json_annotation.dart';

import 'items_model.dart';
import 'contact_model.dart';
import 'history_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class Order {
  int orderId;
  DateTime orderCreatedTime;
  String totalPriceBeforeTax;
  int CGSTPercentage;
  int SGSTPercentage;
  int IGSTPercentage;
  String GrandTotal;
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
        this.CGSTPercentage,
        this.SGSTPercentage,
        this.IGSTPercentage,
        this.GrandTotal,
        this.orderStatus,
        this.tmpOrderId,
        this.paid,
        this.items,
        this.history,
        this.contact});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}