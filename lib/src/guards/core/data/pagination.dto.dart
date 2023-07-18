import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.attendance.entity.dart';
import 'package:rnginfra/src/guards/core/data/pager.dto.dart';

import '../../patroll/domain/entitites/patroll.entity.dart';

part 'pagination.dto.g.dart';

@JsonSerializable()
class Pagination<Type> extends Equatable {
  @_Converter()
  List<Type> results;

  Pager pager;

  Pagination({required this.results, required this.pager});

  Pagination.fill(
      {this.results = const [],
      this.pager = const Pager(
          count: '0', pages: 1, items_per_page: 0, current_page: 1)}) {
    this.pager = Pager(
        count: results.length.toString(),
        pages: 1,
        items_per_page: results.length,
        current_page: 1);
  }

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  @override
  List<Object?> get props => [results, pager];
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
    } else if (json is Map<String, dynamic> &&
        json.containsKey('field_staff_entry') &&
        json.containsKey('field_staff_exit')) {
      return StaffAttendanceEntity.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    if (object is PatrollEntity) {
      return (object).toJson();
    }
    if (object is UserEntity) {
      return (object).toJson();
    }
    if (object is StaffAttendanceEntity) {
      return (object).toJson();
    }
    return {};
  }
}
