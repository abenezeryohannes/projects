// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagEntity _$TagEntityFromJson(Map<String, dynamic> json) => TagEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String?,
      desc: json['desc'] as String?,
      color: json['color'] as String?,
      isDefault: json['isDefault'] as bool?,
      isActive: json['isActive'] as bool? ?? true,
      canDetermine: json['canDetermine'] as bool? ?? false,
      companies: (json['companies'] as List<dynamic>?)
          ?.map((e) => CompanyEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagEntityToJson(TagEntity instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'desc': instance.desc,
      'color': instance.color,
      'isDefault': instance.isDefault,
      'canDetermine': instance.canDetermine,
      'isActive': instance.isActive,
      'companies': instance.companies,
      'user': instance.user,
    };
