import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rnginfra/src/core/utils/utils.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';

void main() {
  PatrollEntity patroll = PatrollEntity(
      id: '1',
      scanned_qr_code_id: '123.0',
      scanned_qr_code_gps_lat: '0.0',
      scanned_qr_code_gps_lng: '0.0',
      body: 'Test Body',
      created: DateTime(2023, 2, 2),
      title: 'Test Title');
  group('fromJson', () {
    test(
      'should return a patroll entity when the JSON is valid',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(Util.readTestFixture('patroll.json'));
//
        final result = PatrollEntity.fromJson(jsonMap);
        // assert
        expect(result, patroll);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a matching JSON when Patroll Entity is converted',
      () async {
        // arrange
        final Map<String, dynamic> result = patroll.toJson();

        final Map<String, dynamic> jsonMap =
            json.decode(Util.readTestFixture('patroll.json'));

        // assert
        expect(result, jsonMap);
      },
    );
  });
}
