// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest.visitation.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestVisitationEntity _$GuestVisitationEntityFromJson(
        Map<String, dynamic> json) =>
    GuestVisitationEntity(
      residents: json['residents'] as String?,
      guest_type: json['guest_type'] as String?,
      vehicle_id: json['vehicle_id'] as String?,
      long_notes: json['long_notes'] as String?,
      short_notes: json['short_notes'] as String?,
      guest_entry: GuestVisitationEntity._fromJson(json['guest_entry']),
      guest_exit: GuestVisitationEntity._fromJson(json['guest_exit']),
      id: json['id'] as String?,
      unit_number: json['unit_number'] as String?,
      created: GuestVisitationEntity._fromJson(json['created']),
      uuid: json['uuid'] as String?,
      guest_image: json['guest_image'] as String?,
      guest_freq_multiple_entry: json['guest_freq_multiple_entry'] == null
          ? false
          : GuestVisitationEntity._boolFromJson(
              json['guest_freq_multiple_entry']),
      guest_frequent_start:
          GuestVisitationEntity._fromJson(json['guest_frequent_start']),
      guest_frequent_end:
          GuestVisitationEntity._fromJson(json['guest_frequent_end']),
    );

Map<String, dynamic> _$GuestVisitationEntityToJson(
        GuestVisitationEntity instance) =>
    <String, dynamic>{
      'residents': instance.residents,
      'guest_type': instance.guest_type,
      'vehicle_id': instance.vehicle_id,
      'long_notes': instance.long_notes,
      'short_notes': instance.short_notes,
      'id': instance.id,
      'unit_number': instance.unit_number,
      'guest_image': instance.guest_image,
      'uuid': instance.uuid,
      'guest_freq_multiple_entry':
          GuestVisitationEntity._boolToJson(instance.guest_freq_multiple_entry),
      'guest_entry': GuestVisitationEntity._toJson(instance.guest_entry),
      'guest_exit': GuestVisitationEntity._toJson(instance.guest_exit),
      'guest_frequent_end':
          GuestVisitationEntity._toJson(instance.guest_frequent_end),
      'guest_frequent_start':
          GuestVisitationEntity._toJson(instance.guest_frequent_start),
      'created': GuestVisitationEntity._toJson(instance.created),
    };
