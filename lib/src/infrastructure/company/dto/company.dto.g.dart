// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDto _$CompanyDtoFromJson(Map<String, dynamic> json) => CompanyDto(
      id: json['id'] as int?,
      name: json['name'] as String,
      userId: json['userId'] as int?,
      banner: json['banner'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      ownerPhoneNumber: json['ownerPhoneNumber'] as String?,
      url: json['url'] as String?,
      deliveryFee: json['deliveryFee'] as String?,
      localImage: json['localImage'] as String?,
      deliveryTime: json['deliveryTime'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$CompanyDtoToJson(CompanyDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'banner': instance.banner,
      'phoneNumber': instance.phoneNumber,
      'ownerPhoneNumber': instance.ownerPhoneNumber,
      'deliveryTime': instance.deliveryTime,
      'deliveryFee': instance.deliveryFee,
      'localImage': instance.localImage,
      'url': instance.url,
      'isActive': instance.isActive,
      'tags': instance.tags,
    };
