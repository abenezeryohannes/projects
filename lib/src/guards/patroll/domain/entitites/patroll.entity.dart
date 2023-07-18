import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patroll.entity.g.dart';

@JsonSerializable()
class PatrollEntity extends Equatable {
  //
  final String? id;

  final String? scanned_qr_code_id;

  final String? scanned_qr_code_gps_lat;

  final String? scanned_qr_code_gps_lng;

  final String title;

  final String body;

  final DateTime created;

  const PatrollEntity({
    this.id,
    required this.scanned_qr_code_id,
    required this.title,
    required this.body,
    required this.created,
    this.scanned_qr_code_gps_lat,
    this.scanned_qr_code_gps_lng,
  });

  @override
  List<Object?> get props => [
        id,
        scanned_qr_code_gps_lat,
        scanned_qr_code_gps_lng,
      ];

  factory PatrollEntity.fromJson(Map<String, dynamic> json) =>
      _$PatrollEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PatrollEntityToJson(this);

  static List<PatrollEntity> fromMany(Iterable l) {
    return List<PatrollEntity>.from(
        l.map((model) => PatrollEntity.fromJson(model)));
  }
}
