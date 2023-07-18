import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pager.dto.g.dart';

@JsonSerializable()
class Pager extends Equatable {
  final String count;
  final int pages;
  final int items_per_page;
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
}
