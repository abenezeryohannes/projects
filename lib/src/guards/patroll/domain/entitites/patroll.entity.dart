import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patroll.entity.g.dart';

@JsonSerializable()
class PatrollEntity extends Equatable {
  static num ACCEPTABLE_DIFF_IN_METTER = 5000000;

  //
  final String? id;

  final String? scanned_qr_code_id;

  final String? scanned_qr_code_gps_lat;

  final String? scanned_qr_code_gps_lng;

  final String? qr_code_gps_lng;

  final String? qr_code_gps_lat;

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
    this.qr_code_gps_lng,
    this.qr_code_gps_lat,
  });

  @override
  List<Object?> get props => [
        id,
        scanned_qr_code_gps_lat,
        scanned_qr_code_gps_lng,
        qr_code_gps_lng,
        qr_code_gps_lat,
      ];

  factory PatrollEntity.fromJson(Map<String, dynamic> json) =>
      _$PatrollEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PatrollEntityToJson(this);

  static List<PatrollEntity> fromMany(Iterable l) {
    return List<PatrollEntity>.from(
        l.map((model) => PatrollEntity.fromJson(model)));
  }

  double getDiff() {
    if (scanned_qr_code_gps_lat == null ||
        scanned_qr_code_gps_lng == null ||
        qr_code_gps_lat == null ||
        qr_code_gps_lng == null) {
      return double.infinity;
    }
    double lat = (double.parse(scanned_qr_code_gps_lat!) -
            double.parse(qr_code_gps_lat!))
        .abs();
    double lng = (double.parse(scanned_qr_code_gps_lng!) -
            double.parse(qr_code_gps_lng!))
        .abs();
    double d = (lat * lat) + (lng * lng);
    return sqrt(d.abs()) * 111139;
  }
}
