// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.attendance.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffAttendanceEntity _$StaffAttendanceEntityFromJson(
        Map<String, dynamic> json) =>
    StaffAttendanceEntity(
      id: json['id'] as String,
      field_staff_entry: json['field_staff_entry'] as String?,
      field_staff_exit: json['field_staff_exit'] as String?,
      field_user_staff: json['field_user_staff'] as String?,
      created: json['created'] as String?,
    )
      ..staff = json['staff'] == null
          ? null
          : UserEntity.fromJson(json['staff'] as Map<String, dynamic>)
      ..user = json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$StaffAttendanceEntityToJson(
        StaffAttendanceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field_staff_entry': instance.field_staff_entry,
      'field_staff_exit': instance.field_staff_exit,
      'field_user_staff': instance.field_user_staff,
      'created': instance.created,
      'staff': instance.staff,
      'user': instance.user,
    };
