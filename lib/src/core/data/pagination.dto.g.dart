// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<Type> _$PaginationFromJson<Type>(Map<String, dynamic> json) =>
    Pagination<Type>(
      results: (json['results'] as List<dynamic>)
          .map((e) => _Converter<Type>().fromJson(e as Object))
          .toList(),
      pager: Pager.fromJson(json['pager'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationToJson<Type>(Pagination<Type> instance) =>
    <String, dynamic>{
      'results': instance.results.map(_Converter<Type>().toJson).toList(),
      'pager': instance.pager,
    };
