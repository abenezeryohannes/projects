import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/domain/entities/guest.visitation.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/entities/resident.entity.dart';
import '../../../../core/errors/failure.dart';

@lazySingleton
class VisitorLocalDatasource {
  final SharedPreferences cache;

  const VisitorLocalDatasource({required this.cache});

  static String VISITOR_KEY = 'VISITOR_KEY';
  static String ACTIVITY_TYPES_KEY = 'ACTIVITY_TYPES_KEY';
  static String RESIDENTS_KEY = 'RESIDENTS_KEY';

  Future<List<GuestVisitationEntity>>? loadVisitors(
      {int? page, String? type, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(VISITOR_KEY + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return GuestVisitationEntity.loadGuestActivities(json.decode(data));
  }

  Future<List<ResidentEntity>>? loadResidents({int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(VISITOR_KEY);
    if (data == null) throw CacheFailure();
    return ResidentEntity.parseMany(json.decode(data));
  }

  Future<bool>? saveVisitorActivities(
      int? page, String? type, List<GuestVisitationEntity> activities) async {
    if (page != null && page > 1) return false;
    return await cache.setString(
        VISITOR_KEY + (page?.toString() ?? ''), json.encode(activities));
  }

  Future<bool>? saveVisitors(int? page, result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(VISITOR_KEY, json.encode(result));
  }

  Future<bool>? saveResidents(int? page, result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(RESIDENTS_KEY, json.encode(result));
  }
}
