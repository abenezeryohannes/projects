// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentEntity _$CommentEntityFromJson(Map<String, dynamic> json) =>
    CommentEntity(
      cid: json['cid'] as int?,
      uid: json['uid'] as int?,
      uuid: json['uuid'] as String?,
      comment_body: json['comment_body'] as String?,
      comment_type: json['comment_type'] as String?,
      langcode: json['langcode'] as String?,
      status: json['status'] as bool?,
      entity_id: json['entity_id'] as int?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      changed: json['changed'] == null
          ? null
          : DateTime.parse(json['changed'] as String),
      field_name: json['field_name'] as String?,
      default_langcode: json['default_langcode'] as bool?,
      vote_count_angry: json['vote_count_angry'] as int?,
      vote_count_laughing: json['vote_count_laughing'] as int?,
      vote_count_like: json['vote_count_like'] as int?,
      vote_count_love: json['vote_count_love'] as int?,
      vote_count_sad: json['vote_count_sad'] as int?,
      vote_count_suprised: json['vote_count_suprised'] as int?,
    )
      ..subject = json['subject'] as String?
      ..name = json['name'] as String?;

Map<String, dynamic> _$CommentEntityToJson(CommentEntity instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'uuid': instance.uuid,
      'langcode': instance.langcode,
      'comment_type': instance.comment_type,
      'subject': instance.subject,
      'name': instance.name,
      'default_langcode': instance.default_langcode,
      'status': instance.status,
      'uid': instance.uid,
      'entity_id': instance.entity_id,
      'created': instance.created?.toIso8601String(),
      'changed': instance.changed?.toIso8601String(),
      'field_name': instance.field_name,
      'comment_body': instance.comment_body,
      'vote_count_like': instance.vote_count_like,
      'vote_count_angry': instance.vote_count_angry,
      'vote_count_laughing': instance.vote_count_laughing,
      'vote_count_sad': instance.vote_count_sad,
      'vote_count_suprised': instance.vote_count_suprised,
      'vote_count_love': instance.vote_count_love,
    };
