// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as int,
      UID: json['UID'] as String?,
      avatar: json['avatar'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String? ?? 'USER',
      language: json['language'] as String? ?? 'en-us',
      theme: json['theme'] as String? ?? 'light',
      isActive: json['isActive'] as bool? ?? true,
      tokens: (json['tokens'] as List<dynamic>?)
          ?.map((e) => TokenEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      companies: (json['companies'] as List<dynamic>?)
          ?.map((e) => CompanyEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => FavoriteEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      chatSent: (json['chatSent'] as List<dynamic>?)
          ?.map((e) => ChatEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      chatReceived: (json['chatReceived'] as List<dynamic>?)
          ?.map((e) => ChatEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'UID': instance.UID,
      'avatar': instance.avatar,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'language': instance.language,
      'theme': instance.theme,
      'isActive': instance.isActive,
      'tokens': instance.tokens,
      'tags': instance.tags,
      'companies': instance.companies,
      'favorites': instance.favorites,
      'chatSent': instance.chatSent,
      'chatReceived': instance.chatReceived,
    };
