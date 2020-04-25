// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    json['accessToken'] as String,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    id: json['id'] as int,
    description: json['description'] as String,
    address: json['address'] as String,
    estimatedDeliveryStart: json['estimatedDeliveryStart'] as String,
    estimatedDeliveryEnd: json['estimatedDeliveryEnd'] as String,
    packageId: json['packageId'] as String,
    orderDate: json['orderDate'] as String,
    state: _$enumDecodeNullable(_$DeliveryStatusEnumMap, json['state']),
    senderName: json['senderName'] as String,
    senderPhoneNumber: json['senderPhoneNumber'] as String,
    senderEmailAddress: json['senderEmailAddress'] as String,
    recipientName: json['recipientName'] as String,
    recipientPhoneNumber: json['recipientPhoneNumber'] as String,
    recipientEmailAddress: json['recipientEmailAddress'] as String,
    paymentInfo: json['paymentInfo'] as String,
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'address': instance.address,
      'estimatedDeliveryStart': instance.estimatedDeliveryStart,
      'estimatedDeliveryEnd': instance.estimatedDeliveryEnd,
      'packageId': instance.packageId,
      'orderDate': instance.orderDate,
      'state': _$DeliveryStatusEnumMap[instance.state],
      'senderName': instance.senderName,
      'senderPhoneNumber': instance.senderPhoneNumber,
      'senderEmailAddress': instance.senderEmailAddress,
      'recipientName': instance.recipientName,
      'recipientPhoneNumber': instance.recipientPhoneNumber,
      'recipientEmailAddress': instance.recipientEmailAddress,
      'paymentInfo': instance.paymentInfo,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DeliveryStatusEnumMap = {
  DeliveryStatus.PackageAssembly: 'PackageAssembly',
  DeliveryStatus.PackageReady: 'PackageReady',
  DeliveryStatus.DeliveryInProgress: 'DeliveryInProgress',
  DeliveryStatus.DeliverySuccess: 'DeliverySuccess',
  DeliveryStatus.DeliveryFailed: 'DeliveryFailed',
};

OrderListResponse _$OrderListResponseFromJson(Map<String, dynamic> json) {
  return OrderListResponse(
    (json['resultList'] as List)
        ?.map((e) =>
            e == null ? null : OrderItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderListResponseToJson(OrderListResponse instance) =>
    <String, dynamic>{
      'resultList': instance.resultList,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return Meta(
    json['currentPage'] as int,
    json['pageCount'] as int,
    json['pageLength'] as int,
  );
}

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageCount': instance.pageCount,
      'pageLength': instance.pageLength,
    };
