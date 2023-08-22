// import 'package:equatable/equatable.dart';
// import 'package:intl/intl.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:rnginfra/src/core/domain/entities/activity.entity.dart';
// part 'guest.activity.entity.g.dart';

// @JsonSerializable()
// class GuestActivityEntity extends Equatable {
//   //
//   String? residents;
//   String? guest_type;
//   String? vehicle_id;
//   String? long_notes;
//   String? short_notes;
//   String? guest_entry;
//   String? guest_exit;
// //
//   String? id;
//   String? unit_number;
//   String? created;
//   String? guest_image;
//   String? uuid;
// //
//   String? guest_frequent_start;
//   String? guest_frequent_end;
//   bool? guest_freq_multiple_entry;
// //
//   DateTime createdAt() {
//     return DateFormat('E, MM/dd/yyyy - HH:mm').parse(created!, true).toLocal();
//   }

//   DateTime? exitAt() {
//     if (guest_exit == null || guest_exit!.isEmpty) return null;
//     return DateFormat('E, MM/dd/yyyy - HH:mm')
//         .parse(guest_exit!, true)
//         .toLocal();
//   }

//   static String? GetDateString(DateTime? d) {
//     if (d == null) return null;
//     return DateFormat('E, MM/dd/yyyy - HH:mm').format(d);
//   }

//   DateTime? entryAt() {
//     if (guest_entry == null || guest_entry!.isEmpty) return null;

//     return DateFormat('E, MM/dd/yyyy - HH:mm')
//         .parse(guest_entry!, true)
//         .toLocal();
//   }

//   ActivityEntity toRequestActivity() {
//     return ActivityEntity(
//         field_guest_entry: guest_entry,
//         field_guest_exit: guest_exit,
//         field_guest_freq_multiple_entry: guest_freq_multiple_entry ?? false,
//         field_guest_frequent_end: guest_frequent_end,
//         field_guest_frequent_start: guest_frequent_start,
//         field_guest_type: guest_type,
//         field_long_notes: long_notes,
//         field_ref_apartment_unit:
//             (unit_number == null || unit_number!.trim().isEmpty)
//                 ? null
//                 : int.parse(unit_number!),
//         field_short_notes: short_notes,
//         field_vehicle_identification: vehicle_id);
//   }

//   GuestActivityEntity(
//       {this.residents,
//       this.guest_type,
//       this.vehicle_id,
//       this.long_notes,
//       this.short_notes,
//       this.guest_entry,
//       this.guest_exit,
//       this.id,
//       this.unit_number,
//       this.created,
//       this.uuid,
//       this.guest_image});

//   factory GuestActivityEntity.fromJson(Map<String, dynamic> json) =>
//       _$GuestActivityEntityFromJson(json);

//   Map<String, dynamic> toJson() => _$GuestActivityEntityToJson(this);

//   @override
//   List<Object?> get props => [
//         residents,
//         guest_type,
//         vehicle_id,
//         long_notes,
//         short_notes,
//         guest_entry,
//         guest_exit,
//         id,
//         unit_number,
//         created,
//         guest_image,
//         uuid
//       ];

//   static Future<List<GuestActivityEntity>> loadGuestActivities(l) async {
//     return List<GuestActivityEntity>.from(
//         l.map((model) => GuestActivityEntity.fromJson(model)));
//   }
// }
