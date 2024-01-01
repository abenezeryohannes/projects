// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create.complaint.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateComplaintEntity _$CreateComplaintEntityFromJson(
        Map<String, dynamic> json) =>
    CreateComplaintEntity(
      type: json['type'] as String? ?? "complaint",
      title: json['title'] as String?,
      field_image: (json['field_image'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      body: json['body'] as String?,
      field_complaint_type: json['field_complaint_type'] as String?,
      field_complaint_urgent: json['field_complaint_urgent'] as int?,
      field_complaint_category: json['field_complaint_category'] as int?,
    );

Map<String, dynamic> _$CreateComplaintEntityToJson(
        CreateComplaintEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'field_image': instance.field_image,
      'body': instance.body,
      'field_complaint_type': instance.field_complaint_type,
      'field_complaint_urgent': instance.field_complaint_urgent,
      'field_complaint_category': instance.field_complaint_category,
    };
