import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.entity.g.dart';

@JsonSerializable()
class CategoryEntity extends Equatable {
  String? name;
  String? tid;
  String? parent_target_id;
  CategoryEntity({this.name, this.tid, this.parent_target_id});
  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  @override
  List<Object?> get props => [name, tid, parent_target_id];

  static Future<List<CategoryEntity>> parseMany(decode) async {
    return List<CategoryEntity>.from(
        decode.map((model) => CategoryEntity.fromJson(model)));
  }
}
