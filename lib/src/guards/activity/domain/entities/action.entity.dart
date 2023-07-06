import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'action.entity.g.dart';

@JsonSerializable()
class ActionEntity extends Equatable {
  final String name;
  final String? color;
  final String? icon;

  const ActionEntity({required this.name, this.color, this.icon});

  factory ActionEntity.fromJson(Map<String, dynamic> json) =>
      _$ActionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActionEntityToJson(this);

  @override
  List<Object?> get props => [name, color, icon];
}
