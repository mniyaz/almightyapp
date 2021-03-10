// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    itemId: json['itemId'] as int,
    itemCode: json['itemCode'] as String,
    itemName: json['itemName'] as String,
    itemPrice: json['itemPrice'] as String,
    itemUnitType: json['itemUnitType'] as String,
    itemDescription: json['itemDescription'] as String,
    category: json['category'] as String,
    itemActive: json['itemActive'] as bool,
    itemPriceRaised: json['itemPriceRaised'] as bool,
    itemPreviousPrice: json['itemPreviousPrice'] as String,
    itemPriceBag: json['itemPriceBag'] as String,
    itemPriceAbove25: json['itemPriceAbove25'] as String,
    itemPrice10To25: json['itemPrice10To25'] as String,
    itemPrice2P5To9P99: json['itemPrice2P5To9P99'] as String,
    itemPriceRaisedBag: json['itemPriceRaisedBag'] as bool,
    itemPreviousPriceBag: json['itemPreviousPriceBag'] as String,
    itemPriceRaisedAbove25: json['itemPriceRaisedAbove25'] as bool,
    itemPreviousPriceAbove25: json['itemPreviousPriceAbove25'] as String,
    itemPriceRaised10To25: json['itemPriceRaised10To25'] as bool,
    itemPreviousPrice10To25: json['itemPreviousPrice10To25'] as String,
    itemPriceRaised2P5To9P99: json['itemPriceRaised2P5To9P99'] as bool,
    itemPreviousPrice2P5To9P99: json['itemPreviousPrice2P5To9P99'] as String,
    prices: (json['prices'] as List)
        ?.map(
            (e) => e == null ? null : Price.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'itemCode': instance.itemCode,
      'itemName': instance.itemName,
      'itemPrice': instance.itemPrice,
      'itemUnitType': instance.itemUnitType,
      'itemDescription': instance.itemDescription,
      'category': instance.category,
      'itemActive': instance.itemActive,
      'itemPriceRaised': instance.itemPriceRaised,
      'itemPreviousPrice': instance.itemPreviousPrice,
      'itemPriceBag': instance.itemPriceBag,
      'itemPriceAbove25': instance.itemPriceAbove25,
      'itemPrice10To25': instance.itemPrice10To25,
      'itemPrice2P5To9P99': instance.itemPrice2P5To9P99,
      'itemPriceRaisedBag': instance.itemPriceRaisedBag,
      'itemPreviousPriceBag': instance.itemPreviousPriceBag,
      'itemPriceRaisedAbove25': instance.itemPriceRaisedAbove25,
      'itemPreviousPriceAbove25': instance.itemPreviousPriceAbove25,
      'itemPriceRaised10To25': instance.itemPriceRaised10To25,
      'itemPreviousPrice10To25': instance.itemPreviousPrice10To25,
      'itemPriceRaised2P5To9P99': instance.itemPriceRaised2P5To9P99,
      'itemPreviousPrice2P5To9P99': instance.itemPreviousPrice2P5To9P99,
      'prices': instance.prices,
    };
