// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest.activity.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestActivityEntity _$GuestActivityEntityFromJson(Map<String, dynamic> json) =>
    GuestActivityEntity(
      residents: json['residents'] as String?,
      guest_type: json['guest_type'] as String?,
      vehicle_id: json['vehicle_id'] as String?,
      long_notes: json['long_notes'] as String?,
      short_notes: json['short_notes'] as String?,
      guest_entry: json['guest_entry'] as String?,
      guest_exit: json['guest_exit'] as String?,
      id: json['id'] as String?,
      unit_number: json['unit_number'] as String?,
      created: json['created'] as String?,
      guest_image: json['guest_image'] as String?,
    );

Map<String, dynamic> _$GuestActivityEntityToJson(
        GuestActivityEntity instance) =>
    <String, dynamic>{
      'residents': instance.residents,
      'guest_type': instance.guest_type,
      'vehicle_id': instance.vehicle_id,
      'long_notes': instance.long_notes,
      'short_notes': instance.short_notes,
      'guest_entry': instance.guest_entry,
      'guest_exit': instance.guest_exit,
      'id': instance.id,
      'unit_number': instance.unit_number,
      'created': instance.created,
      'guest_image': instance.guest_image,
    };
