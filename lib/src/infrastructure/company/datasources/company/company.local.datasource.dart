import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../appcore/errors/failure.dart';

@lazySingleton
class CompanyLocalDataSource {
  late SharedPreferences cache;
  static String COMPANY_KEY = "COMPANY_KEY";
  CompanyLocalDataSource({required this.cache});

  Future<bool>? saveCompanies(int? page, List<CompanyEntity>? companies) async {
    if (page != null && page > 1) return false;
    return await cache.setString(COMPANY_KEY, json.encode(companies));
  }

  Future<List<CompanyEntity>> loadCompanies() async {
    final data = cache.getString(COMPANY_KEY);
    if (data == null) throw CacheFailure(message: "No Cache!");
    return parseFromJson(json.decode(data));
  }

  Future<List<CompanyEntity>> parseFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<CompanyEntity>.from(
        l.map((model) => CompanyEntity.fromJson(model)));
  }
}
