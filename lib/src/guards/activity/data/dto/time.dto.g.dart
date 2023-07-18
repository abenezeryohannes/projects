// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeDto _$TimeDtoFromJson(Map<String, dynamic> json) => TimeDto(
      format: json['format'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$TimeDtoToJson(TimeDto instance) => <String, dynamic>{
      'value': instance.value,
      'format': instance.format,
    };
