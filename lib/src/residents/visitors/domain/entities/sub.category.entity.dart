import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sub.category.entity.g.dart';

@JsonSerializable()
class SubCategoryEntity extends Equatable {
  String? name;

  SubCategoryEntity({this.name});

  factory SubCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryEntityToJson(this);

  @override
  List<Object?> get props => [name];
}
