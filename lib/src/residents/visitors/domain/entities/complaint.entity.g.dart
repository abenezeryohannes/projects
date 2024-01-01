// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintEntity _$ComplaintEntityFromJson(Map<String, dynamic> json) =>
    ComplaintEntity(
      nid: json['nid'] as int?,
      uuid: json['uuid'] as String?,
      vid: json['vid'] as int?,
      langcode: json['langcode'] as String?,
      type: json['type'] as String?,
      revision_timestamp: json['revision_timestamp'] == null
          ? null
          : DateTime.parse(json['revision_timestamp'] as String),
      revision_uid: json['revision_uid'] as int?,
      revision_url: json['revision_url'] as String?,
      status: json['status'] as bool?,
      uid: json['uid'] as int?,
      title: json['title'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      changed: json['changed'] == null
          ? null
          : DateTime.parse(json['changed'] as String),
      promote: json['promote'] as bool?,
      sticky: json['sticky'] as bool?,
      field_complaint_category_id: json['field_complaint_category_id'] as int?,
      default_langcode: json['default_langcode'] as bool?,
      last_comment_timestamp: json['last_comment_timestamp'] == null
          ? null
          : DateTime.parse(json['last_comment_timestamp'] as String),
      revision_translation_affected:
          json['revision_translation_affected'] as bool?,
      body: json['body'] as String?,
      field_image: (json['field_image'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      commentStatus: json['commentStatus'] as int?,
      field_complaint_category: json['field_complaint_category'] as String?,
      field_complaint_type: json['field_complaint_type'] as String?,
      field_complaint_urgent: json['field_complaint_urgent'] as bool?,
      comment_count: json['comment_count'] as int?,
      vote_count_angry: json['vote_count_angry'] as int?,
      vote_count_laughing: json['vote_count_laughing'] as int?,
      vote_count_like: json['vote_count_like'] as int?,
      vote_count_love: json['vote_count_love'] as int?,
      vote_count_sad: json['vote_count_sad'] as int?,
      vote_count_suprised: json['vote_count_suprised'] as int?,
      last_comment_uid: json['last_comment_uid'] as int?,
    )..field_image_ids = (json['field_image_ids'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList();

Map<String, dynamic> _$ComplaintEntityToJson(ComplaintEntity instance) =>
    <String, dynamic>{
      'nid': instance.nid,
      'uuid': instance.uuid,
      'vid': instance.vid,
      'langcode': instance.langcode,
      'type': instance.type,
      'revision_timestamp': instance.revision_timestamp?.toIso8601String(),
      'revision_uid': instance.revision_uid,
      'revision_url': instance.revision_url,
      'status': instance.status,
      'uid': instance.uid,
      'title': instance.title,
      'created': instance.created?.toIso8601String(),
      'changed': instance.changed?.toIso8601String(),
      'promote': instance.promote,
      'sticky': instance.sticky,
      'default_langcode': instance.default_langcode,
      'revision_translation_affected': instance.revision_translation_affected,
      'body': instance.body,
      'field_complaint_category': instance.field_complaint_category,
      'field_complaint_type': instance.field_complaint_type,
      'field_complaint_urgent': instance.field_complaint_urgent,
      'commentStatus': instance.commentStatus,
      'comment_count': instance.comment_count,
      'last_comment_timestamp':
          instance.last_comment_timestamp?.toIso8601String(),
      'last_comment_uid': instance.last_comment_uid,
      'field_image': instance.field_image,
      'field_image_ids': instance.field_image_ids,
      'field_complaint_category_id': instance.field_complaint_category_id,
      'vote_count_like': instance.vote_count_like,
      'vote_count_angry': instance.vote_count_angry,
      'vote_count_laughing': instance.vote_count_laughing,
      'vote_count_sad': instance.vote_count_sad,
      'vote_count_suprised': instance.vote_count_suprised,
      'vote_count_love': instance.vote_count_love,
    };
