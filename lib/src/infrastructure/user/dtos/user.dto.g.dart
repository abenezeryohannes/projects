// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'] as int,
      UID: json['UID'] as String?,
      avatar: json['avatar'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String? ?? 'USER',
      language: json['language'] as String? ?? 'en-us',
      theme: json['theme'] as String? ?? 'light',
      isActive: json['isActive'] as bool? ?? true,
    )..localImage = json['localImage'] as String?;

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'UID': instance.UID,
      'avatar': instance.avatar,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'language': instance.language,
      'theme': instance.theme,
      'isActive': instance.isActive,
      'localImage': instance.localImage,
    };
