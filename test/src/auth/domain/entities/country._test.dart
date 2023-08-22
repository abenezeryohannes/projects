import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rnginfra/src/auth/domain/entities/country.entity.dart';
import 'package:rnginfra/src/core/utils/utils.dart';

void main() {
  final country = MyCountry(
      dial_code: '+1', name: 'United States', emoji: '🇺🇸', code: 'US');
  group('fromJson', () {
    test(
      'should return a country entity when the JSON is valid',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(Util.readTestFixture('country.json'));
//
        final result = MyCountry.fromJson(jsonMap);
        // assert
        expect(result, country);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a matching JSON when Country Entity is converted',
      () async {
        // arrange
        final Map<String, dynamic> result = country.toJson();

        final Map<String, dynamic> jsonMap =
            json.decode(Util.readTestFixture('country.json'));
//
        // assert
        expect(result, jsonMap);
      },
    );
  });
}
