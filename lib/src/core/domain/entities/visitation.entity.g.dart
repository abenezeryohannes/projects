// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitation.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitationEntity _$VisitationEntityFromJson(Map<String, dynamic> json) =>
    VisitationEntity(
      field_ref_apartment_unit: json['field_ref_apartment_unit'] as int?,
      field_guest_type: json['field_guest_type'] as String?,
      field_vehicle_identification:
          json['field_vehicle_identification'] as String?,
      field_long_notes: json['field_long_notes'] as String?,
      field_short_notes: json['field_short_notes'] as String?,
      field_guest_entry: VisitationEntity._fromJson(json['field_guest_entry']),
      field_guest_exit: VisitationEntity._fromJson(json['field_guest_exit']),
      id: json['id'] as int?,
      uid: json['uid'] as int?,
      uuid: json['uuid'] as String?,
      created: VisitationEntity._fromJson(json['created']),
      field_guest_image: json['field_guest_image'] as String?,
      residents: json['residents'] as String?,
      unit_number: json['unit_number'] as String?,
      field_guest_freq_multiple_entry:
          json['field_guest_freq_multiple_entry'] as bool? ?? false,
      field_guest_frequent_start:
          VisitationEntity._fromJson(json['field_guest_frequent_start']),
      field_guest_frequent_end:
          VisitationEntity._fromJson(json['field_guest_frequent_end']),
    );

Map<String, dynamic> _$VisitationEntityToJson(VisitationEntity instance) =>
    <String, dynamic>{
      'field_ref_apartment_unit': instance.field_ref_apartment_unit,
      'field_guest_type': instance.field_guest_type,
      'field_vehicle_identification': instance.field_vehicle_identification,
      'field_long_notes': instance.field_long_notes,
      'field_short_notes': instance.field_short_notes,
      'id': instance.id,
      'uid': instance.uid,
      'uuid': instance.uuid,
      'field_guest_image': instance.field_guest_image,
      'field_guest_freq_multiple_entry':
          instance.field_guest_freq_multiple_entry,
      'field_guest_entry': VisitationEntity._toJson(instance.field_guest_entry),
      'field_guest_exit': VisitationEntity._toJson(instance.field_guest_exit),
      'field_guest_frequent_end':
          VisitationEntity._toJson(instance.field_guest_frequent_end),
      'field_guest_frequent_start':
          VisitationEntity._toJson(instance.field_guest_frequent_start),
      'created': VisitationEntity._toJson(instance.created),
      'residents': instance.residents,
      'unit_number': instance.unit_number,
    };
