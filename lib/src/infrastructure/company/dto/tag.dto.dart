import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.dto.g.dart';

@JsonSerializable()
class TagDto extends Equatable {
  int? id;
  String name;
  String? color;
  String? desc;
  bool? isDefault;
  bool? isActive;

  TagDto({
    this.id,
    required this.name,
    this.color,
    this.desc,
    this.isDefault = false,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [id, name, color, desc, isDefault, isActive];

  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TagDtoToJson(this);

  dynamic get(String propName) {
    switch (propName) {
      default:
        return name;
    }
  }

  static Future<List<TagDto>> loadCompanies(l) async {
    return List<TagDto>.from(l.map((model) => TagDto.fromJson(model)));
  }
}
