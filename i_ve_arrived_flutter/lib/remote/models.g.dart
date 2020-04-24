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

OrderItemClient _$OrderItemClientFromJson(Map<String, dynamic> json) {
  return OrderItemClient(
    json['id'] as String,
    json['orderDate'] as String,
  );
}

Map<String, dynamic> _$OrderItemClientToJson(OrderItemClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderDate': instance.orderDate,
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

OrderListClientResponse _$OrderListClientResponseFromJson(
    Map<String, dynamic> json) {
  return OrderListClientResponse(
    (json['resultList'] as List)
        ?.map((e) => e == null
            ? null
            : OrderItemClient.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderListClientResponseToJson(
        OrderListClientResponse instance) =>
    <String, dynamic>{
      'resultList': instance.resultList,
    };
