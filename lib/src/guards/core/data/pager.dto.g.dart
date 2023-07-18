// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pager.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pager _$PagerFromJson(Map<String, dynamic> json) => Pager(
      count: json['count'] as String,
      pages: json['pages'] as int,
      items_per_page: json['items_per_page'] as int,
      current_page: json['current_page'] as int,
    );

Map<String, dynamic> _$PagerToJson(Pager instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'items_per_page': instance.items_per_page,
      'current_page': instance.current_page,
    };
