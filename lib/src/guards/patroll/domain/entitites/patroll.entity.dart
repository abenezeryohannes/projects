import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patroll.entity.g.dart';

@JsonSerializable()
class PatrollEntity extends Equatable {
  //
  final int? id;

  final double scanned_qr_code_id;

  final double scanned_qr_code_gps_lat;

  final double scanned_qr_code_gps_lng;

  final String title;

  final String body;

  final DateTime created;

  final int qr_code_id;

  final double qr_code_gps_lat;

  final double qr_code_gps_lng;

  const PatrollEntity({
    this.id,
    required this.scanned_qr_code_id,
    this.scanned_qr_code_gps_lat = 0,
    this.scanned_qr_code_gps_lng = 0,
    required this.title,
    required this.body,
    this.qr_code_id = -1,
    this.qr_code_gps_lat = 0,
    this.qr_code_gps_lng = 0,
    required this.created,
  });

  @override
  List<Object?> get props => [qr_code_gps_lat, qr_code_gps_lng, qr_code_id];

  factory PatrollEntity.fromJson(Map<String, dynamic> json) =>
      _$PatrollEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PatrollEntityToJson(this);

  static Future<List<PatrollEntity>> loadPatrolls(Iterable l) async {
    return List<PatrollEntity>.from(
        l.map((model) => PatrollEntity.fromJson(model)));
  }
}
