// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_user_staff.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldUserStaffDto _$FieldUserStaffDtoFromJson(Map<String, dynamic> json) =>
    FieldUserStaffDto(
      target_type: json['target_type'] as String?,
      target_id: json['target_id'] as int,
      target_uuid: json['target_uuid'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$FieldUserStaffDtoToJson(FieldUserStaffDto instance) =>
    <String, dynamic>{
      'target_id': instance.target_id,
      'target_type': instance.target_type,
      'target_uuid': instance.target_uuid,
      'url': instance.url,
    };
