// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyEntity _$CompanyEntityFromJson(Map<String, dynamic> json) =>
    CompanyEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      userId: json['userId'] as int,
      banner: json['banner'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      ownerPhoneNumber: json['ownerPhoneNumber'] as String?,
      badge: json['badge'] as String?,
      badgeColor: json['badgeColor'] as String?,
      url: json['url'] as String?,
      liked: json['liked'] as int?,
      deliveryFee: json['deliveryFee'] as String?,
      deliveryTime: json['deliveryTime'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      favoritesof: (json['favoritesof'] as List<dynamic>?)
          ?.map((e) => FavoriteEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$CompanyEntityToJson(CompanyEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'banner': instance.banner,
      'phoneNumber': instance.phoneNumber,
      'ownerPhoneNumber': instance.ownerPhoneNumber,
      'deliveryTime': instance.deliveryTime,
      'deliveryFee': instance.deliveryFee,
      'badge': instance.badge,
      'badgeColor': instance.badgeColor,
      'liked': instance.liked,
      'url': instance.url,
      'isActive': instance.isActive,
      'tags': instance.tags,
      'user': instance.user,
      'favoritesof': instance.favoritesof,
    };
