// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCountry _$MyCountryFromJson(Map<String, dynamic> json) => MyCountry(
      name: json['name'] as String,
      dial_code: json['dial_code'] as String,
      emoji: json['emoji'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$MyCountryToJson(MyCountry instance) => <String, dynamic>{
      'name': instance.name,
      'dial_code': instance.dial_code,
      'emoji': instance.emoji,
      'code': instance.code,
    };
