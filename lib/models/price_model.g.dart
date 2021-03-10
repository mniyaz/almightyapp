// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) {
  return Price(
    pId: json['pId'] as int,
    greaterThan: (json['greaterThan'] as num)?.toDouble(),
    greaterThanOrEqualTo: json['greaterThanOrEqualTo'] as bool,
    lessThan: (json['lessThan'] as num)?.toDouble(),
    lessThanOrEqualTo: json['lessThanOrEqualTo'] as bool,
    price: (json['price'] as num)?.toDouble(),
    itemPriceRaised: json['itemPriceRaised'] as bool,
    previousPrice: (json['previousPrice'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'pId': instance.pId,
      'greaterThan': instance.greaterThan,
      'greaterThanOrEqualTo': instance.greaterThanOrEqualTo,
      'lessThan': instance.lessThan,
      'lessThanOrEqualTo': instance.lessThanOrEqualTo,
      'price': instance.price,
      'itemPriceRaised': instance.itemPriceRaised,
      'previousPrice': instance.previousPrice,
    };
