// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add.vote.complaint.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddVoteComplaintEntity _$AddVoteComplaintEntityFromJson(
        Map<String, dynamic> json) =>
    AddVoteComplaintEntity(
      type: json['type'] as String?,
      entity_id: json['entity_id'] as int?,
      entity_type: json['entity_type'] as String? ?? 'node',
      target_type: json['target_type'] as String? ?? 'vote_type',
      value: json['value'] as int? ?? 1,
      value_type: json['value_type'] as String? ?? 'points',
    );

Map<String, dynamic> _$AddVoteComplaintEntityToJson(
        AddVoteComplaintEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'target_type': instance.target_type,
      'entity_type': instance.entity_type,
      'entity_id': instance.entity_id,
      'value': instance.value,
      'value_type': instance.value_type,
    };
