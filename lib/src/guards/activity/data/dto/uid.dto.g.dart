// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uid.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UidDto _$UidDtoFromJson(Map<String, dynamic> json) => UidDto(
      target_id: json['target_id'] as int,
      user: json['user'] as String?,
      target_uuid: json['target_uuid'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$UidDtoToJson(UidDto instance) => <String, dynamic>{
      'target_id': instance.target_id,
      'user': instance.user,
      'target_uuid': instance.target_uuid,
      'url': instance.url,
    };
