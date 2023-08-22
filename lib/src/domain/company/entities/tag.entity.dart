import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';

import '../../user/entities/user.entity.dart';

part 'tag.entity.g.dart';

@JsonSerializable()
class TagEntity extends Equatable {
  int id;
  String? type;
  String name;
  String? desc;
  String? color;
  bool? isDefault;
  bool canDetermine;
  bool isActive;

  List<CompanyEntity>? companies;
  UserEntity? user;

  TagEntity(
      {required this.id,
      required this.name,
      this.type,
      this.desc,
      this.color,
      this.isDefault,
      this.isActive = true,
      this.canDetermine = false,
      this.companies,
      this.user});

  @override
  List<Object?> get props => [
        id,
        name,
        desc,
        type,
        color,
        canDetermine,
        isDefault,
        isActive,
        companies,
        user
      ];

  factory TagEntity.fromJson(Map<String, dynamic> json) =>
      _$TagEntityFromJson(json);

  dynamic get(String propName) {
    switch (propName) {
      default:
        return name;
    }
  }

  Map<String, dynamic> toJson() => _$TagEntityToJson(this);
}
