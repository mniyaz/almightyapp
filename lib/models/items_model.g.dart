// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
    cartId: json['cartId'] as int,
    cartCreatedTime: json['cartCreatedTime'] == null
        ? null
        : DateTime.parse(json['cartCreatedTime'] as String),
    productName: json['productName'] as String,
    qty: json['qty'] as int,
    UOM: json['UOM'] as String,
    price: json['price'] as String,
    cGSTPercentage: json['cGSTPercentage'] as int,
    sGSTPercentage: json['sGSTPercentage'] as int,
    iGSTPercentage: json['iGSTPercentage'] as int,
    rowTotal: json['rowTotal'] as String,
  );
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'cartId': instance.cartId,
      'cartCreatedTime': instance.cartCreatedTime?.toIso8601String(),
      'productName': instance.productName,
      'qty': instance.qty,
      'UOM': instance.UOM,
      'price': instance.price,
      'cGSTPercentage': instance.cGSTPercentage,
      'sGSTPercentage': instance.sGSTPercentage,
      'iGSTPercentage': instance.iGSTPercentage,
      'rowTotal': instance.rowTotal,
    };
