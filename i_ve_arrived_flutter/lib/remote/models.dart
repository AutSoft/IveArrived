import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class LoginResponse{
  final String accessToken;

  LoginResponse(this.accessToken);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

enum DeliveryStatus{
  PackageAssembly,
  PackageReady,
  DeliveryInProgress,
  DeliverySuccess,
  DeliveryFailed,
}

@JsonSerializable()
class OrderItem{
  final int id;
  final String description;
  final String address;
  final String estimatedDeliveryStart;
  final String estimatedDeliveryEnd;
  final String packageId;
  final String orderDate;
  final DeliveryStatus state;
  final String senderName;
  final String senderPhoneNumber;
  final String senderEmailAddress;
  final String recipientName;
  final String recipientPhoneNumber;
  final String recipientEmailAddress;
  final String paymentInfo;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  const OrderItem({
    this.id,
    this.description,
    this.address,
    this.estimatedDeliveryStart,
    this.estimatedDeliveryEnd,
    this.packageId,
    this.orderDate,
    this.state,
    this.senderName,
    this.senderPhoneNumber,
    this.senderEmailAddress,
    this.recipientName,
    this.recipientPhoneNumber,
    this.recipientEmailAddress,
    this.paymentInfo,
  });

  OrderItem copyWith({
    int id,
    String description,
    String address,
    String estimatedDeliveryStart,
    String estimatedDeliveryEnd,
    String packageId,
    String orderDate,
    double lat,
    double lng,
    DeliveryStatus state,
    String senderName,
    String senderPhoneNumber,
    String senderEmailAddress,
    String recipientName,
    String recipientPhoneNumber,
    String recipientEmailAddress,
    String paymentInfo,
  }) {
    return new OrderItem(
      id: id ?? this.id,
      description: description ?? this.description,
      address: address ?? this.address,
      estimatedDeliveryStart: estimatedDeliveryStart ?? this.estimatedDeliveryStart,
      estimatedDeliveryEnd: estimatedDeliveryEnd ?? this.estimatedDeliveryEnd,
      packageId: packageId ?? this.packageId,
      orderDate: orderDate ?? this.orderDate,
      state: state ?? this.state,
      senderName: senderName ?? this.senderName,
      senderPhoneNumber: senderPhoneNumber ?? this.senderPhoneNumber,
      senderEmailAddress: senderEmailAddress ?? this.senderEmailAddress,
      recipientName: recipientName ?? this.recipientName,
      recipientPhoneNumber: recipientPhoneNumber ?? this.recipientPhoneNumber,
      recipientEmailAddress: recipientEmailAddress ?? this.recipientEmailAddress,
      paymentInfo: paymentInfo ?? this.paymentInfo,
    );
  }

}

@JsonSerializable()
class OrderListResponse{
  final List<OrderItem> resultList;

  OrderListResponse(this.resultList);

  factory OrderListResponse.fromJson(Map<String, dynamic> json) => _$OrderListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListResponseToJson(this);
}

@JsonSerializable()
class Meta{
  final int currentPage;
  final int pageCount;
  final int pageLength;

  Meta(this.currentPage, this.pageCount, this.pageLength);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}