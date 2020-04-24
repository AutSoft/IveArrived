// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateResponse _$RateResponseFromJson(Map<String, dynamic> json) {
  return RateResponse(
    (json['rates'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
    json['base'] as String,
    json['date'] as String,
  );
}

Map<String, dynamic> _$RateResponseToJson(RateResponse instance) =>
    <String, dynamic>{
      'rates': instance.rates,
      'base': instance.base,
      'date': instance.date,
    };
