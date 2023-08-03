// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagDto _$TagDtoFromJson(Map<String, dynamic> json) => TagDto(
      id: json['id'] as int?,
      name: json['name'] as String,
      color: json['color'] as String?,
      desc: json['desc'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$TagDtoToJson(TagDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'desc': instance.desc,
      'isDefault': instance.isDefault,
      'isActive': instance.isActive,
    };
