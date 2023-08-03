// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) => ChatEntity(
      id: json['id'] as int,
      data: json['data'] as String?,
      type: json['type'] as String? ?? 'text',
      isActive: json['isActive'] as bool? ?? true,
      receiver: json['receiver'] == null
          ? null
          : UserEntity.fromJson(json['receiver'] as Map<String, dynamic>),
      sender: json['sender'] == null
          ? null
          : UserEntity.fromJson(json['sender'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ChatEntityToJson(ChatEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'type': instance.type,
      'isActive': instance.isActive,
      'receiver': instance.receiver,
      'sender': instance.sender,
      'createdAt': instance.createdAt.toIso8601String(),
    };
