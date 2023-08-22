// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resident.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResidentEntity _$ResidentEntityFromJson(Map<String, dynamic> json) =>
    ResidentEntity(
      name: json['name'] as String?,
      uid: json['uid'] as String?,
      unit_number: json['unit_number'] as String?,
    );

Map<String, dynamic> _$ResidentEntityToJson(ResidentEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'unit_number': instance.unit_number,
    };
