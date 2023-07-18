import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../auth/domain/entities/user.entity.dart';
import '../../../patroll/domain/entitites/patroll.entity.dart';

part 'value.dto.g.dart';

@JsonSerializable()
class ValueDto<Type> extends Equatable {
  @_Converter()
  final Type value;
  const ValueDto({required this.value});
  @override
  List<Object?> get props => [value];
//
//
//
  factory ValueDto.fromJson(Map<String, dynamic> json) =>
      _$ValueDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ValueDtoToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('scanned_qr_code_id')) {
      return PatrollEntity.fromJson(json) as T;
    } else if (json is Map<String, dynamic> &&
        json.containsKey('name') &&
        json.containsKey('uid')) {
      return UserEntity.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    if (object is PatrollEntity) {
      return (object).toJson();
    }
    return {};
  }
}
