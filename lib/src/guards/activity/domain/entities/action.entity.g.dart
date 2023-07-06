// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionEntity _$ActionEntityFromJson(Map<String, dynamic> json) => ActionEntity(
      name: json['name'] as String,
      color: json['color'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$ActionEntityToJson(ActionEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'icon': instance.icon,
    };
