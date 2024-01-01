// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add.comment.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentEntity _$AddCommentEntityFromJson(Map<String, dynamic> json) =>
    AddCommentEntity(
      comment_type: json['comment_type'] as String? ?? 'comment',
      comment_body: json['comment_body'] as String?,
      entity_type: json['entity_type'] as String? ?? 'node',
      entity_id: json['entity_id'] as int?,
      field_name: json['field_name'] as String? ?? 'field_comments',
    );

Map<String, dynamic> _$AddCommentEntityToJson(AddCommentEntity instance) =>
    <String, dynamic>{
      'comment_type': instance.comment_type,
      'entity_type': instance.entity_type,
      'field_name': instance.field_name,
      'entity_id': instance.entity_id,
      'comment_body': instance.comment_body,
    };
