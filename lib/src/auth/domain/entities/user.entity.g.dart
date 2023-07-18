// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      url: json['url'] as String?,
      name: json['name'] as String,
      uid: json['uid'] as String,
      avatar: json['avatar'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      position: json['position'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'avatar': instance.avatar,
      'phoneNumber': instance.phoneNumber,
      'position': instance.position,
      'url': instance.url,
    };
