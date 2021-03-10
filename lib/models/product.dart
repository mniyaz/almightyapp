import 'package:almighty/models/price_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int itemId;
  String itemCode;
  String itemName;
  String itemPrice;
  String itemUnitType;
  String itemDescription;
  String category;
  bool itemActive;
  bool itemPriceRaised;
  String itemPreviousPrice;
  String itemPriceBag;
  String itemPriceAbove25;
  String itemPrice10To25;
  String itemPrice2P5To9P99;
  bool itemPriceRaisedBag;
  String itemPreviousPriceBag;
  bool itemPriceRaisedAbove25;
  String itemPreviousPriceAbove25;
  bool itemPriceRaised10To25;
  String itemPreviousPrice10To25;
  bool itemPriceRaised2P5To9P99;
  String itemPreviousPrice2P5To9P99;
  List<Price> prices;

  Product(
      {this.itemId,
      this.itemCode,
      this.itemName,
      this.itemPrice,
      this.itemUnitType,
      this.itemDescription,
      this.category,
      this.itemActive,
      this.itemPriceRaised,
      this.itemPreviousPrice,
      this.itemPriceBag,
      this.itemPriceAbove25,
      this.itemPrice10To25,
      this.itemPrice2P5To9P99,
      this.itemPriceRaisedBag,
      this.itemPreviousPriceBag,
      this.itemPriceRaisedAbove25,
      this.itemPreviousPriceAbove25,
      this.itemPriceRaised10To25,
      this.itemPreviousPrice10To25,
      this.itemPriceRaised2P5To9P99,
      this.itemPreviousPrice2P5To9P99,
      this.prices});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
