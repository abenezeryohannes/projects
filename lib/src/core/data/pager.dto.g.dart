// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pager.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pager _$PagerFromJson(Map<String, dynamic> json) => Pager(
      count: Pager._fromJson(json['count']),
      pages: Pager._fromJson(json['pages']),
      items_per_page: Pager._fromJson(json['items_per_page']),
      current_page: Pager._fromJson(json['current_page']),
    );

Map<String, dynamic> _$PagerToJson(Pager instance) => <String, dynamic>{
      'count': Pager._toJson(instance.count),
      'pages': Pager._toJson(instance.pages),
      'items_per_page': Pager._toJson(instance.items_per_page),
      'current_page': Pager._toJson(instance.current_page),
    };
