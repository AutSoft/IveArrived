import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class LoginResponse{
  final String accessToken;

  LoginResponse(this.accessToken);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class OrderItemClient{
  final String id;
  final String orderDate;

  OrderItemClient(this.id, this.orderDate);

  factory OrderItemClient.fromJson(Map<String, dynamic> json) => _$OrderItemClientFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemClientToJson(this);
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
class OrderListClientResponse{
  final List<OrderItemClient> resultList;

  OrderListClientResponse(this.resultList);

  factory OrderListClientResponse.fromJson(Map<String, dynamic> json) => _$OrderListClientResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListClientResponseToJson(this);
}