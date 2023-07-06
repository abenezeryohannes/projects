import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity.type.entity.g.dart';

@JsonSerializable()
class ActivityTypeEntity extends Equatable {
  final String name;
  final String? icon;
  final String? color;
  final bool needApproval;
  const ActivityTypeEntity(
      {this.color, this.needApproval = true, required this.name, this.icon});

  factory ActivityTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivityTypeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityTypeEntityToJson(this);

  dynamic get(String propName) {
    switch (propName) {
      default:
        return name;
    }
  }

  @override
  List<Object?> get props => [name, icon, color, needApproval];

  static Future<List<ActivityTypeEntity>> loadActivityTypes(l) async {
    return List<ActivityTypeEntity>.from(
        l.map((model) => ActivityTypeEntity.fromJson(model)));
  }
}
