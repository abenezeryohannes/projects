import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
part 'staff.attendance.entity.g.dart';

@JsonSerializable()
class StaffAttendanceEntity extends Equatable {
  String id;
  String? field_staff_entry;
  String? field_staff_exit;
  String? field_user_staff;
  String? created;

  UserEntity? staff;
  UserEntity? user;

  DateTime createdAt() {
    return DateFormat('E, MM/dd/yyyy - HH:mm').parse(created!, true).toLocal();
  }

  DateTime? exitAt() {
    if (field_staff_exit == null || field_staff_exit!.isEmpty) return null;
    return DateFormat('E, MM/dd/yyyy - HH:mm')
        .parse(field_staff_exit!, true)
        .toLocal();
  }

  static String? GetDateString(DateTime? d) {
    if (d == null) return null;
    return DateFormat('E, MM/dd/yyyy - HH:mm').format(d);
  }

  DateTime? entryAt() {
    if (field_staff_entry == null || field_staff_entry!.isEmpty) return null;

    return DateFormat('E, MM/dd/yyyy - HH:mm')
        .parse(field_staff_entry!, true)
        .toLocal();
  }

  StaffAttendanceEntity(
      {required this.id,
      this.field_staff_entry,
      this.field_staff_exit,
      this.field_user_staff,
      this.created});

  factory StaffAttendanceEntity.fromJson(Map<String, dynamic> json) =>
      _$StaffAttendanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StaffAttendanceEntityToJson(this);

  @override
  List<Object?> get props =>
      [id, field_staff_entry, field_staff_exit, field_user_staff, created];

  static Future<List<StaffAttendanceEntity>> loadAttendances(l) async {
    return List<StaffAttendanceEntity>.from(
        l.map((model) => StaffAttendanceEntity.fromJson(model)));
  }
}
