import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/pager.dto.dart';
import '../../../../core/data/pagination.dto.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entitites/patroll.entity.dart';

@singleton
class PatrollLocalDataSource {
  final SharedPreferences cache;

  const PatrollLocalDataSource({required this.cache});

  static String PATROLL_KEY = 'patrolls';

  Future<Pagination<PatrollEntity>>? loadPatrolls(
      {int? page, int? limit}) async {
    if (page != null && page > 1) {
      return Pagination<PatrollEntity>(
          results: const [],
          pager: const Pager(
            count: 0,
            pages: 0,
            current_page: 0,
            items_per_page: 0,
          ));
    }
    final data = cache.getString(PATROLL_KEY);
    if (data == null) throw CacheFailure();
    final results = PatrollEntity.fromMany(json.decode(data));
    return Pagination<PatrollEntity>(
        pager: Pager(
            count: results.length,
            pages: 0,
            items_per_page: results.length,
            current_page: 0),
        results: results);
  }

  Future<bool>? savePatroll(int? page, List<PatrollEntity> patrolls) async {
    if (page != null && page > 1) return false;
    return await cache.setString(PATROLL_KEY, json.encode(patrolls));
  }
}
