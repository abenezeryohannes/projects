import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'visitation.entity.g.dart';

@JsonSerializable()
class VisitationEntity extends Equatable {
  static const int multiplier = 1000;

  int? field_ref_apartment_unit;
  String? field_guest_type;
  String? field_vehicle_identification;
  String? field_long_notes;
  String? field_short_notes;
//
  int? id;
  int? uid;
  String? uuid;
  String? field_guest_image;
//
  bool field_guest_freq_multiple_entry;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? field_guest_entry;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? field_guest_exit;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? field_guest_frequent_end;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? field_guest_frequent_start;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? created;
// this is
  String? residents;
  String? unit_number;

  static String? GetDateString(DateTime? d) {
    if (d == null) return null;
    return (d.millisecondsSinceEpoch / multiplier).round().toString();
  }

  DateTime? createdAt() {
    if (created == null || created!.isEmpty) return null;
    return DateTime.fromMillisecondsSinceEpoch(
        int.parse(created!) * multiplier);
  }

  DateTime? exitAt() {
    if (field_guest_exit == null || field_guest_exit!.isEmpty) return null;
    return DateTime.fromMillisecondsSinceEpoch(
        (int.parse(field_guest_exit!) / multiplier).round());
  }

  DateTime? entryAt() {
    if (field_guest_entry == null || field_guest_entry!.isEmpty) return null;
    return DateTime.fromMillisecondsSinceEpoch(
        (int.parse(field_guest_entry!) / multiplier).round());
  }

  void setEntry(DateTime date) {
    field_guest_entry = (date.millisecondsSinceEpoch * multiplier).toString();
  }

  void setExit(DateTime date) {
    field_guest_exit = (date.millisecondsSinceEpoch * multiplier).toString();
  }

  void setFrequentEntry(DateTime date) {
    field_guest_frequent_start =
        (date.millisecondsSinceEpoch * multiplier).toString();
  }

  void setFrequentExit(DateTime date) {
    field_guest_frequent_end =
        (date.millisecondsSinceEpoch * multiplier).toString();
  }

  DateTime? frequentStart() {
    if (field_guest_frequent_start == null ||
        field_guest_frequent_start!.isEmpty) return null;
    return DateTime.fromMillisecondsSinceEpoch(
        (int.parse(field_guest_frequent_start!) / multiplier).round());
  }

  DateTime? frequentEnd() {
    if (field_guest_frequent_end == null || field_guest_frequent_end!.isEmpty) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(
        (int.parse(field_guest_frequent_end!) / multiplier).round());
  }

  // DateTime? frequentStartAt() {
  //   if (field_guest_frequent_start == null ||
  //       field_guest_frequent_start!.isEmpty) return null;

  //   return DateFormat('E, MM/dd/yyyy - HH:mm')
  //       .parse(field_guest_frequent_start!, true)
  //       .toLocal();
  // }

  // DateTime? frequentEndAt() {
  //   if (field_guest_frequent_end == null || field_guest_frequent_end!.isEmpty) {
  //     return null;
  //   }

  //   return DateFormat('E, MM/dd/yyyy - HH:mm')
  //       .parse(field_guest_frequent_end!, true)
  //       .toLocal();
  // }

  static String? GetFormatedDateString(DateTime? d) {
    if (d == null) return null;
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(d);
  }

  VisitationEntity(
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
      this.field_guest_image,
      this.residents,
      this.unit_number,
      this.field_guest_freq_multiple_entry = false,
      this.field_guest_frequent_start,
      this.field_guest_frequent_end});

  factory VisitationEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisitationEntityToJson(this);

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
        field_guest_image,
        residents,
        unit_number,
        field_guest_freq_multiple_entry,
        field_guest_frequent_start,
        field_guest_frequent_end
      ];

  static Future<List<VisitationEntity>> loadActivities(l) async {
    return List<VisitationEntity>.from(
        l.map((model) => VisitationEntity.fromJson(model)));
  }

  static int? _toJson(String? object) {
    if (object != null && object.isNotEmpty) {
      return int.parse(object);
    }
    return null;
  }

  static String? _fromJson(dynamic json) {
    if (json is bool) {
      return null;
    } else if (json is int) {
      return json.toString();
    } else if (json is String) {
      return (json);
    }
    return json as String?;
  }
}
