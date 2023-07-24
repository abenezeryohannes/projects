import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pager.dto.g.dart';

@JsonSerializable()
class Pager extends Equatable {
  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final int count;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final int pages;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final int items_per_page;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final int current_page;

  const Pager(
      {required this.count,
      required this.pages,
      required this.items_per_page,
      required this.current_page});

  factory Pager.fromJson(Map<String, dynamic> json) => _$PagerFromJson(json);

  Map<String, dynamic> toJson() => _$PagerToJson(this);

  @override
  List<Object?> get props => [count, pages, items_per_page, current_page];

  static int _toJson(int value) => value;
  static int _fromJson(dynamic value) {
    if (value is String) {
      return int.parse(value);
    } else {
      return (value) as int;
    }
  }
}
