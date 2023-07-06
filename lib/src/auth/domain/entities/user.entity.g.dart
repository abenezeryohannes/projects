// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      position: json['position'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'phoneNumber': instance.phoneNumber,
      'position': instance.position,
    };
