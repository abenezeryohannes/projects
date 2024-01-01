// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryEntity(
      name: json['name'] as String?,
      tid: json['tid'] as String?,
      parent_target_id: json['parent_target_id'] as String?,
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tid': instance.tid,
      'parent_target_id': instance.parent_target_id,
    };
