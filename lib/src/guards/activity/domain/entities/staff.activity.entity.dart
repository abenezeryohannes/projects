import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
part 'staff.activity.entity.g.dart';

@JsonSerializable()
class StaffActivityEntity extends Equatable {
  int id;
  String? uuid;
  DateTime? staffEntry;
  DateTime? staffExit;
  DateTime? created;
  DateTime? changed;

  UserEntity? staff;
  UserEntity? user;

  StaffActivityEntity(
      {required this.id,
      this.uuid,
      this.staffEntry,
      this.staffExit,
      this.created,
      this.changed,
      this.staff,
      this.user});

  factory StaffActivityEntity.fromJson(Map<String, dynamic> json) =>
      _$StaffActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StaffActivityEntityToJson(this);

  @override
  List<Object?> get props =>
      [id, uuid, staffEntry, staffExit, created, changed, created];

  static Future<List<StaffActivityEntity>> loadActivities(l) async {
    return List<StaffActivityEntity>.from(
        l.map((model) => StaffActivityEntity.fromJson(model)));
  }
}
