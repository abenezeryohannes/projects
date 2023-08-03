import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:linko/src/domain/auth/entities/token.entity.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';

import '../../domain/company/entities/company.entity.dart';
part 'wrapper.dto.g.dart';

@JsonSerializable()
class WrapperDto<Type> extends Equatable {
  @_Converter()
  Type? data;

  @_Converter()
  List<Type>? datas;

  int statusCode;
  bool success;
  String? message;
  int? count;
  int? page;
  int? total_pages;
  int? limit;
  String? sort_by;
  String? sort;

  WrapperDto(
      {this.data,
      this.statusCode = 200,
      this.success = true,
      this.message,
      this.count = 0,
      this.datas,
      this.page = 0,
      this.total_pages = 0,
      this.limit = 25,
      this.sort_by,
      this.sort});

  factory WrapperDto.fromJson(Map<String, dynamic> json) =>
      _$WrapperDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WrapperDtoToJson(this);

  @override
  List<Object?> get props => [
        data,
        statusCode,
        success,
        message,
        datas,
        count,
        page,
        total_pages,
        limit,
        sort_by,
        sort
      ];
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('receiver') &&
        json.containsKey('sender')) {
      return ChatEntity.fromJson(json) as T;
    } else if (json is Map<String, dynamic> &&
        json.containsKey('name') &&
        json.containsKey('banner')) {
      return CompanyEntity.fromJson(json) as T;
    } else if (json is Map<String, dynamic> &&
        json.containsKey('fullName') &&
        json.containsKey('phoneNumber')) {
      return UserEntity.fromJson(json) as T;
    } else if (json is Map<String, dynamic> &&
        json.containsKey('token') &&
        json.containsKey('fcmToken')) {
      return TokenEntity.fromJson(json) as T;
    } else if (json is Map<String, dynamic> &&
        json.containsKey('name') &&
        json.containsKey('isDefault')) {
      return TagEntity.fromJson(json) as T;
    } else if (json is Map<String, dynamic> &&
        json.containsKey('user') &&
        json.containsKey('company')) {
      return FavoriteEntity.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    if (object is ChatEntity) {
      return (object).toJson();
    } else if (object is CompanyEntity) {
      return (object).toJson();
    } else if (object is TagEntity) {
      return (object).toJson();
    } else if (object is FavoriteEntity) {
      return (object).toJson();
    } else if (object is UserEntity) {
      return (object).toJson();
    } else if (object is TokenEntity) {
      return (object).toJson();
    }
    return {};
  }
}
