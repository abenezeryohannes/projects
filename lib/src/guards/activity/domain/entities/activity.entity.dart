import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity.entity.g.dart';

@JsonSerializable()
class ActivityEntity extends Equatable {
  int? field_ref_apartment_unit;
  String? field_guest_type;
  String? field_vehicle_identification;
  String? field_long_notes;
  String? field_short_notes;
  String? field_guest_entry;
  String? field_guest_exit;
//
  int? id;
  int? uid;
  String? uuid;
  String? created;
  String? field_guest_image;

//
  DateTime createdAt() {
    return DateFormat('E, MM/dd/yyyy - HH:mm').parse(created!, true).toLocal();
  }

  DateTime? exitAt() {
    if (field_guest_exit == null || field_guest_exit!.isEmpty) return null;
    return DateFormat('E, MM/dd/yyyy - HH:mm')
        .parse(field_guest_exit!, true)
        .toLocal();
  }

  static String? GetDateString(DateTime? d) {
    if (d == null) return null;
    return DateFormat('E, MM/dd/yyyy - HH:mm').format(d);
  }

  DateTime? entryAt() {
    if (field_guest_entry == null || field_guest_entry!.isEmpty) return null;

    return DateFormat('E, MM/dd/yyyy - HH:mm')
        .parse(field_guest_entry!, true)
        .toLocal();
  }

  ActivityEntity(
      {this.field_ref_apartment_unit,
      this.field_guest_type,
      this.field_vehicle_identification,
      this.field_long_notes,
      this.field_short_notes,
      this.field_guest_entry,
      this.field_guest_exit,
      this.id,
      this.uid,
      this.uuid,
      this.created,
      this.field_guest_image});

  factory ActivityEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityEntityToJson(this);

  @override
  List<Object?> get props => [
        field_ref_apartment_unit,
        field_guest_type,
        field_vehicle_identification,
        field_long_notes,
        field_short_notes,
        field_guest_entry,
        field_guest_exit,
        id,
        uid,
        uuid,
        created,
        field_guest_image
      ];

  static Future<List<ActivityEntity>> loadActivities(l) async {
    return List<ActivityEntity>.from(
        l.map((model) => ActivityEntity.fromJson(model)));
  }
}
