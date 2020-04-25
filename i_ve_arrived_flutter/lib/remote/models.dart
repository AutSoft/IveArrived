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
  IN_PROGRESS, DELIVERED, CANCELLED
}

@JsonSerializable()
class OrderItem{
  final String id;
  final String orderDate;
  final String address;
  final double lat;
  final double lng;
  final DeliveryStatus status;

  OrderItem({this.id, this.orderDate, this.address, this.lat, this.lng, this.status});

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  OrderItem copyWith({
    String id,
    String orderDate,
    String address,
    double lat,
    double lng,
    DeliveryStatus status,
  }) {
    return new OrderItem(
      id: id ?? this.id,
      orderDate: orderDate ?? this.orderDate,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      status: status ?? this.status,
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