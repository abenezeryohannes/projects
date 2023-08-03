// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteEntity _$FavoriteEntityFromJson(Map<String, dynamic> json) =>
    FavoriteEntity(
      id: json['id'] as int,
      userId: json['userId'] as int?,
      companyId: json['companyId'] as int?,
      company: json['company'] == null
          ? null
          : CompanyEntity.fromJson(json['company'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$FavoriteEntityToJson(FavoriteEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'companyId': instance.companyId,
      'isActive': instance.isActive,
      'company': instance.company,
      'user': instance.user,
    };
