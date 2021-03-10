import 'package:json_annotation/json_annotation.dart';

part 'price_model.g.dart';

@JsonSerializable()
class Price {
  int pId;
  double greaterThan;
  bool greaterThanOrEqualTo;
  double lessThan;
  bool lessThanOrEqualTo;
  double price;
  bool itemPriceRaised;
  double previousPrice;

  Price(
      {this.pId,
      this.greaterThan,
      this.greaterThanOrEqualTo,
      this.lessThan,
      this.lessThanOrEqualTo,
      this.price,
      this.itemPriceRaised,
      this.previousPrice});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
