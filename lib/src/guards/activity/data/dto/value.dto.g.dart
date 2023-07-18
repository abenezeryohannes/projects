// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueDto<Type> _$ValueDtoFromJson<Type>(Map<String, dynamic> json) =>
    ValueDto<Type>(
      value: _Converter<Type>().fromJson(json['value'] as Object),
    );

Map<String, dynamic> _$ValueDtoToJson<Type>(ValueDto<Type> instance) =>
    <String, dynamic>{
      'value': _Converter<Type>().toJson(instance.value),
    };
