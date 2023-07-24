// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityEntity _$ActivityEntityFromJson(Map<String, dynamic> json) =>
    ActivityEntity(
      field_ref_apartment_unit: json['field_ref_apartment_unit'] as int?,
      field_guest_type: json['field_guest_type'] as String?,
      field_vehicle_identification:
          json['field_vehicle_identification'] as String?,
      field_long_notes: json['field_long_notes'] as String?,
      field_short_notes: json['field_short_notes'] as String?,
      field_guest_entry: json['field_guest_entry'] as String?,
      field_guest_exit: json['field_guest_exit'] as String?,
      id: json['id'] as int?,
      uid: json['uid'] as int?,
      uuid: json['uuid'] as String?,
      created: json['created'] as String?,
      field_guest_image: json['field_guest_image'] as String?,
    );

Map<String, dynamic> _$ActivityEntityToJson(ActivityEntity instance) =>
    <String, dynamic>{
      'field_ref_apartment_unit': instance.field_ref_apartment_unit,
      'field_guest_type': instance.field_guest_type,
      'field_vehicle_identification': instance.field_vehicle_identification,
      'field_long_notes': instance.field_long_notes,
      'field_short_notes': instance.field_short_notes,
      'field_guest_entry': instance.field_guest_entry,
      'field_guest_exit': instance.field_guest_exit,
      'id': instance.id,
      'uid': instance.uid,
      'uuid': instance.uuid,
      'created': instance.created,
      'field_guest_image': instance.field_guest_image,
    };
