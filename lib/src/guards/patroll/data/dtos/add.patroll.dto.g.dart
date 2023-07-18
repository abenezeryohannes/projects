// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add.patroll.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPatrollDto _$AddPatrollDtoFromJson(Map<String, dynamic> json) =>
    AddPatrollDto(
      qr_code_id: json['qr_code_id'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$AddPatrollDtoToJson(AddPatrollDto instance) =>
    <String, dynamic>{
      'qr_code_id': instance.qr_code_id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
