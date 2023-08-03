// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenEntity _$TokenEntityFromJson(Map<String, dynamic> json) => TokenEntity(
      id: json['id'] as int? ?? -1,
      token: json['token'] as String,
      fcmToken: json['fcmToken'] as String?,
      role: json['role'] as String? ?? 'USER',
      until: DateTime.parse(json['until'] as String),
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenEntityToJson(TokenEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'fcmToken': instance.fcmToken,
      'role': instance.role,
      'until': instance.until.toIso8601String(),
      'user': instance.user,
    };
