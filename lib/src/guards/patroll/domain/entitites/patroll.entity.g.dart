// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patroll.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatrollEntity _$PatrollEntityFromJson(Map<String, dynamic> json) =>
    PatrollEntity(
      id: json['id'] as String?,
      scanned_qr_code_id: json['scanned_qr_code_id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      created: DateTime.parse(json['created'] as String),
      scanned_qr_code_gps_lat: json['scanned_qr_code_gps_lat'] as String?,
      scanned_qr_code_gps_lng: json['scanned_qr_code_gps_lng'] as String?,
      qr_code_gps_lng: json['qr_code_gps_lng'] as String?,
      qr_code_gps_lat: json['qr_code_gps_lat'] as String?,
    );

Map<String, dynamic> _$PatrollEntityToJson(PatrollEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scanned_qr_code_id': instance.scanned_qr_code_id,
      'scanned_qr_code_gps_lat': instance.scanned_qr_code_gps_lat,
      'scanned_qr_code_gps_lng': instance.scanned_qr_code_gps_lng,
      'qr_code_gps_lng': instance.qr_code_gps_lng,
      'qr_code_gps_lat': instance.qr_code_gps_lat,
      'title': instance.title,
      'body': instance.body,
      'created': instance.created.toIso8601String(),
    };
