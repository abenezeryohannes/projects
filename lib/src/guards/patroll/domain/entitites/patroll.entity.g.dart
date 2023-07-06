// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patroll.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatrollEntity _$PatrollEntityFromJson(Map<String, dynamic> json) =>
    PatrollEntity(
      id: json['id'] as int?,
      scanned_qr_code_id: (json['scanned_qr_code_id'] as num).toDouble(),
      scanned_qr_code_gps_lat:
          (json['scanned_qr_code_gps_lat'] as num?)?.toDouble() ?? 0,
      scanned_qr_code_gps_lng:
          (json['scanned_qr_code_gps_lng'] as num?)?.toDouble() ?? 0,
      title: json['title'] as String,
      body: json['body'] as String,
      qr_code_id: json['qr_code_id'] as int? ?? -1,
      qr_code_gps_lat: (json['qr_code_gps_lat'] as num?)?.toDouble() ?? 0,
      qr_code_gps_lng: (json['qr_code_gps_lng'] as num?)?.toDouble() ?? 0,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$PatrollEntityToJson(PatrollEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scanned_qr_code_id': instance.scanned_qr_code_id,
      'scanned_qr_code_gps_lat': instance.scanned_qr_code_gps_lat,
      'scanned_qr_code_gps_lng': instance.scanned_qr_code_gps_lng,
      'title': instance.title,
      'body': instance.body,
      'created': instance.created.toIso8601String(),
      'qr_code_id': instance.qr_code_id,
      'qr_code_gps_lat': instance.qr_code_gps_lat,
      'qr_code_gps_lng': instance.qr_code_gps_lng,
    };
