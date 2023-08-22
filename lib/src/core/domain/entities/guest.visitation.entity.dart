import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rnginfra/src/core/domain/entities/activity.entity.dart';
part 'guest.visitation.entity.g.dart';

@JsonSerializable()
class GuestVisitationEntity extends Equatable {
  //
  String? residents;
  String? guest_type;
  String? vehicle_id;
  String? long_notes;
  String? short_notes;
//
  String? id;
  String? unit_number;
  String? guest_image;
  String? uuid;
//
//

  @JsonKey(
    toJson: _boolToJson,
    fromJson: _boolFromJson,
  )
  bool guest_freq_multiple_entry;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? guest_entry;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? guest_exit;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? guest_frequent_end;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? guest_frequent_start;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  String? created;

  static String? GetDateString(DateTime? d) {
    if (d == null) return null;
    return (d.millisecondsSinceEpoch / 1000).toString();
  }

  DateTime createdAt() {
    if (created == null || created!.isEmpty) {
      return DateTime.now().subtract(const Duration(days: 999999));
    }
    DateTime? result = getTimeFromString(created!);
    return result ?? DateTime.now().subtract(const Duration(days: 999999));
  }

  DateTime? exitAt() {
    if (guest_exit == null || guest_exit!.isEmpty) return null;
    return getTimeFromString(guest_exit!);
  }

  DateTime? entryAt() {
    if (guest_entry == null || guest_entry!.isEmpty) return null;
    return getTimeFromString(guest_entry!);
  }

  DateTime? frequentStart() {
    if (guest_frequent_start == null || guest_frequent_start!.isEmpty)
      return null;
    return getTimeFromString(guest_frequent_start!);
  }

  DateTime? frequentEnd() {
    if (guest_frequent_end == null || guest_frequent_end!.isEmpty) {
      return null;
    }
    return getTimeFromString(guest_frequent_end!);
  }

  DateTime? getTimeFromString(String x) {
    if (int.tryParse(x) != null) {
      return DateTime.fromMillisecondsSinceEpoch(int.parse(x) * 1000);
    } else {
      if (x.startsWith('<time')) return null;
      return DateFormat('E, MM/dd/yyyy - HH:mm').parse(x, true).toLocal();
    }
  }

  GuestVisitationEntity(
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
      this.uuid,
      this.guest_image,
      this.guest_freq_multiple_entry = false,
      this.guest_frequent_start,
      this.guest_frequent_end});

  factory GuestVisitationEntity.fromJson(Map<String, dynamic> json) =>
      _$GuestVisitationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GuestVisitationEntityToJson(this);

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
        guest_image,
        uuid,
        guest_freq_multiple_entry,
        guest_frequent_start,
        guest_frequent_end
      ];

  static Future<List<GuestVisitationEntity>> loadGuestActivities(l) async {
    return List<GuestVisitationEntity>.from(
        l.map((model) => GuestVisitationEntity.fromJson(model)));
  }

  static String? _toJson(String? object) {
    if (object != null && object.isNotEmpty) {
      return (object);
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

  static bool _boolFromJson(dynamic json) {
    if (json is bool) {
      return json;
    } else if (json is int) {
      return json > 0;
    } else if (json is String) {
      return int.parse(json) > 0;
    }
    return false;
  }

  static bool _boolToJson(bool object) {
    if (object) {
      return true;
    }
    return false;
  }

  ActivityEntity toRequestActivity() {
    return ActivityEntity(
        field_guest_entry: guest_entry,
        field_guest_exit: guest_exit,
        field_guest_freq_multiple_entry: guest_freq_multiple_entry,
        field_guest_frequent_end: guest_frequent_end,
        field_guest_frequent_start: guest_frequent_start,
        field_guest_type: guest_type,
        field_long_notes: long_notes,
        field_ref_apartment_unit:
            (unit_number == null || unit_number!.trim().isEmpty)
                ? null
                : int.parse(unit_number!),
        field_short_notes: short_notes,
        field_vehicle_identification: vehicle_id);
  }
}
