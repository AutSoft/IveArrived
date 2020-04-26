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
class CourierData{
  final String role;
  final String displayName;
  final String logoUrl;
  final String phoneNumber;

  CourierData(this.role, this.displayName, this.logoUrl, this.phoneNumber);

  factory CourierData.fromJson(Map<String, dynamic> json) => _$CourierDataFromJson(json);
  Map<String, dynamic> toJson() => _$CourierDataToJson(this);
}

@JsonSerializable()
class OrderItem{
  final int id;
  final String description;
  final String address;
  final String estimatedDeliveryStart;
  final String estimatedDeliveryEnd;
  final String packageId;
  final DeliveryStatus state;
  final String senderName;
  final String senderPhoneNumber;
  final String senderEmailAddress;
  final String recipientName;
  final String recipientPhoneNumber;
  final String recipientEmailAddress;
  final String paymentInfo;
  final CourierData courier;
  final CourierData courierService;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  const OrderItem({this.courier, this.courierService,
    this.id,
    this.description,
    this.address,
    this.estimatedDeliveryStart,
    this.estimatedDeliveryEnd,
    this.packageId,
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
    DeliveryStatus state,
    String senderName,
    String senderPhoneNumber,
    String senderEmailAddress,
    String recipientName,
    String recipientPhoneNumber,
    String recipientEmailAddress,
    String paymentInfo,
    CourierData courier,
    CourierData courierService,
  }) {
    return new OrderItem(
      id: id ?? this.id,
      description: description ?? this.description,
      address: address ?? this.address,
      estimatedDeliveryStart: estimatedDeliveryStart ?? this.estimatedDeliveryStart,
      estimatedDeliveryEnd: estimatedDeliveryEnd ?? this.estimatedDeliveryEnd,
      packageId: packageId ?? this.packageId,
      state: state ?? this.state,
      senderName: senderName ?? this.senderName,
      senderPhoneNumber: senderPhoneNumber ?? this.senderPhoneNumber,
      senderEmailAddress: senderEmailAddress ?? this.senderEmailAddress,
      recipientName: recipientName ?? this.recipientName,
      recipientPhoneNumber: recipientPhoneNumber ?? this.recipientPhoneNumber,
      recipientEmailAddress: recipientEmailAddress ?? this.recipientEmailAddress,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      courier: courier ?? this.courier,
      courierService: courierService ?? this.courierService,
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

@JsonSerializable()
class MeData{
  final String role;
  final String displayName;
  final String contactName;
  final String address;
  final String city;
  final String zipCode;
  final String country;
  final String email;
  final String logoUrl;

  MeData({this.role, this.displayName, this.contactName, this.address, this.city, this.zipCode, this.country, this.email, this.logoUrl});

  factory MeData.fromJson(Map<String, dynamic> json) => _$MeDataFromJson(json);
  Map<String, dynamic> toJson() => _$MeDataToJson(this);
}