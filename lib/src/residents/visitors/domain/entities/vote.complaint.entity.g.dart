// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.complaint.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteComplaintEntity _$VoteComplaintEntityFromJson(Map<String, dynamic> json) =>
    VoteComplaintEntity(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      type: json['type'] as String?,
      entity_id: json['entity_id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      value: json['value'] as int?,
      user_id: json['user_id'] as int?,
      vote_source: json['vote_source'] as String?,
    )..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String);

Map<String, dynamic> _$VoteComplaintEntityToJson(
        VoteComplaintEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'entity_id': instance.entity_id,
      'value': instance.value,
      'user_id': instance.user_id,
      'timestamp': instance.timestamp?.toIso8601String(),
      'vote_source': instance.vote_source,
    };
