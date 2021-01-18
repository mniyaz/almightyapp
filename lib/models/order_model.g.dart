// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    orderId: json['orderId'] as int,
    orderCreatedTime: json['orderCreatedTime'] == null
        ? null
        : DateTime.parse(json['orderCreatedTime'] as String),
    totalPriceBeforeTax: json['totalPriceBeforeTax'] as String,
    CGSTPercentage: json['CGSTPercentage'] as int,
    SGSTPercentage: json['SGSTPercentage'] as int,
    IGSTPercentage: json['IGSTPercentage'] as int,
    GrandTotal: json['GrandTotal'] as String,
    orderStatus: json['orderStatus'] as String,
    tmpOrderId: json['tmpOrderId'] as String,
    paid: json['paid'] as bool,
    rejectReason: json['rejectReason'] as String,
    items: (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Items.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    history: (json['history'] as List)
        ?.map((e) =>
            e == null ? null : History.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    contact: json['contact'] == null
        ? null
        : Contact.fromJson(json['contact'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'orderCreatedTime': instance.orderCreatedTime?.toIso8601String(),
      'totalPriceBeforeTax': instance.totalPriceBeforeTax,
      'CGSTPercentage': instance.CGSTPercentage,
      'SGSTPercentage': instance.SGSTPercentage,
      'IGSTPercentage': instance.IGSTPercentage,
      'GrandTotal': instance.GrandTotal,
      'orderStatus': instance.orderStatus,
      'tmpOrderId': instance.tmpOrderId,
      'paid': instance.paid,
      'rejectReason': instance.rejectReason,
      'items': instance.items,
      'history': instance.history,
      'contact': instance.contact,
    };
