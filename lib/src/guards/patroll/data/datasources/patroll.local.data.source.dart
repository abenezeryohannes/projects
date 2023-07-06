import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entitites/patroll.entity.dart';

@singleton
class PatrollLocalDataSource {
  final SharedPreferences cache;

  const PatrollLocalDataSource({required this.cache});

  static String PATROLL_KEY = 'patrolls';

  Future<List<PatrollEntity>>? loadPatrolls({int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(PATROLL_KEY);
    if (data == null) throw CacheFailure();
    return PatrollEntity.loadPatrolls(json.decode(data));
  }

  Future<bool>? savePatroll(int? page, List<PatrollEntity> patrolls) async {
    if (page != null && page > 1) return false;
    return await cache.setString(PATROLL_KEY, json.encode(patrolls));
  }
}
