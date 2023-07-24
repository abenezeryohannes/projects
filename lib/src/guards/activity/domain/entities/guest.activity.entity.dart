import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'guest.activity.entity.g.dart';

@JsonSerializable()
class GuestActivityEntity extends Equatable {
  //
  String? residents;
  String? guest_type;
  String? vehicle_id;
  String? long_notes;
  String? short_notes;
  String? guest_entry;
  String? guest_exit;
//
  String? id;
  String? unit_number;
  String? created;
  String? guest_image;
//
//
  DateTime createdAt() {
    return DateFormat('E, MM/dd/yyyy - HH:mm').parse(created!, true).toLocal();
  }

  DateTime? exitAt() {
    if (guest_exit == null || guest_exit!.isEmpty) return null;
    return DateFormat('E, MM/dd/yyyy - HH:mm')
        .parse(guest_exit!, true)
        .toLocal();
  }

  static String? GetDateString(DateTime? d) {
    if (d == null) return null;
    return DateFormat('E, MM/dd/yyyy - HH:mm').format(d);
  }

  DateTime? entryAt() {
    if (guest_entry == null || guest_entry!.isEmpty) return null;

    return DateFormat('E, MM/dd/yyyy - HH:mm')
        .parse(guest_entry!, true)
        .toLocal();
  }

  GuestActivityEntity(
      {this.residents,
      this.guest_type,
      this.vehicle_id,
      this.long_notes,
      this.short_notes,
      this.guest_entry,
      this.guest_exit,
      this.id,
      this.unit_number,
      this.created,
      this.guest_image});

  factory GuestActivityEntity.fromJson(Map<String, dynamic> json) =>
      _$GuestActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GuestActivityEntityToJson(this);

  @override
  List<Object?> get props => [
        residents,
        guest_type,
        vehicle_id,
        long_notes,
        short_notes,
        guest_entry,
        guest_exit,
        id,
        unit_number,
        created,
        guest_image
      ];

  static Future<List<GuestActivityEntity>> loadGuestActivities(l) async {
    return List<GuestActivityEntity>.from(
        l.map((model) => GuestActivityEntity.fromJson(model)));
  }
}
