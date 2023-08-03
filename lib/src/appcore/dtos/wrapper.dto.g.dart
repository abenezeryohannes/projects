// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrapper.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrapperDto<Type> _$WrapperDtoFromJson<Type>(Map<String, dynamic> json) =>
    WrapperDto<Type>(
      data: _$JsonConverterFromJson<Object, Type>(
          json['data'], _Converter<Type?>().fromJson),
      statusCode: json['statusCode'] as int? ?? 200,
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      count: json['count'] as int? ?? 0,
      datas: (json['datas'] as List<dynamic>?)
          ?.map((e) => _Converter<Type>().fromJson(e as Object))
          .toList(),
      page: json['page'] as int? ?? 0,
      total_pages: json['total_pages'] as int? ?? 0,
      limit: json['limit'] as int? ?? 25,
      sort_by: json['sort_by'] as String?,
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$WrapperDtoToJson<Type>(WrapperDto<Type> instance) =>
    <String, dynamic>{
      'data': _$JsonConverterToJson<Object, Type>(
          instance.data, _Converter<Type?>().toJson),
      'datas': instance.datas?.map(_Converter<Type>().toJson).toList(),
      'statusCode': instance.statusCode,
      'success': instance.success,
      'message': instance.message,
      'count': instance.count,
      'page': instance.page,
      'total_pages': instance.total_pages,
      'limit': instance.limit,
      'sort_by': instance.sort_by,
      'sort': instance.sort,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
