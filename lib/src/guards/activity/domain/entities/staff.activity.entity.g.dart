// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.activity.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffActivityEntity _$StaffActivityEntityFromJson(Map<String, dynamic> json) =>
    StaffActivityEntity(
      id: json['id'] as int,
      uuid: json['uuid'] as String?,
      staffEntry: json['staffEntry'] == null
          ? null
          : DateTime.parse(json['staffEntry'] as String),
      staffExit: json['staffExit'] == null
          ? null
          : DateTime.parse(json['staffExit'] as String),
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      changed: json['changed'] == null
          ? null
          : DateTime.parse(json['changed'] as String),
      staff: json['staff'] == null
          ? null
          : UserEntity.fromJson(json['staff'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StaffActivityEntityToJson(
        StaffActivityEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'staffEntry': instance.staffEntry?.toIso8601String(),
      'staffExit': instance.staffExit?.toIso8601String(),
      'created': instance.created?.toIso8601String(),
      'changed': instance.changed?.toIso8601String(),
      'staff': instance.staff,
      'user': instance.user,
    };
