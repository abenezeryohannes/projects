// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDto _$ChatDtoFromJson(Map<String, dynamic> json) => ChatDto(
      data: json['data'] as String?,
      type: json['type'] as String? ?? 'text',
      senderID: json['senderID'],
    )..reveiverID = json['reveiverID'] as int?;

Map<String, dynamic> _$ChatDtoToJson(ChatDto instance) => <String, dynamic>{
      'data': instance.data,
      'type': instance.type,
      'reveiverID': instance.reveiverID,
      'senderID': instance.senderID,
    };
