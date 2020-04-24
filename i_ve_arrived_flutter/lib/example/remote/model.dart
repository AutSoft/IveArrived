import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class RateResponse{
  final Map<String, num> rates;
  final String base;
  final String date;

  RateResponse(this.rates, this.base, this.date);

  factory RateResponse.fromJson(Map<String, dynamic> json) => _$RateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RateResponseToJson(this);
}