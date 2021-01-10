import 'package:json_annotation/json_annotation.dart';

part 'items_model.g.dart';

@JsonSerializable()
class Items {
  
  int cartId;
  DateTime cartCreatedTime;
  String productName;
  int qty;
  String UOM;
  String price;
  int cGSTPercentage;
  int sGSTPercentage;
  int iGSTPercentage;
  String rowTotal;

  Items(
      {this.cartId,
        this.cartCreatedTime,
        this.productName,
        this.qty,
        this.UOM,
        this.price,
        this.cGSTPercentage,
        this.sGSTPercentage,
        this.iGSTPercentage,
        this.rowTotal});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
