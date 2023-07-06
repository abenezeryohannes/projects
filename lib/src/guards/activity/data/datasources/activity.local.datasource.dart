import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failure.dart';

@singleton
class ActivityLocalDatasource {
  final SharedPreferences cache;

  const ActivityLocalDatasource({required this.cache});

  static String GUEST_ACTIVITY_KEY = 'GUEST_ACTIVITY_KEY';
  static String STAFF_ACTIVITY_KEY = 'STAFF_ACTIVITY_KEY';

  static String GUESTS_KEY = 'GUESTS_KEY';
  static String STAFFS_KEY = 'STAFFS_KEY';
  static String ACTIVITY_TYPES_KEY = 'ACTIVITY_TYPES_KEY';

  Future<List<ActivityEntity>>? loadGuestActivity(
      {int? page, String? type, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache
        .getString(GUEST_ACTIVITY_KEY + (type != null ? ('___' + type) : ''));
    if (data == null) throw CacheFailure();
    return ActivityEntity.loadActivities(json.decode(data));
  }

  Future<List<ActivityEntity>>? loadStaffActivity(
      {int? page, String? type, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache
        .getString(STAFF_ACTIVITY_KEY + (type != null ? ('___' + type) : ''));
    if (data == null) throw CacheFailure();
    return ActivityEntity.loadActivities(json.decode(data));
  }

  Future<List<UserEntity>>? loadStaffs({int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(STAFFS_KEY);
    if (data == null) throw CacheFailure();
    return UserEntity.loadUsers(json.decode(data));
  }

  Future<List<UserEntity>>? loadGuests({int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(GUESTS_KEY);
    if (data == null) throw CacheFailure();
    return UserEntity.loadUsers(json.decode(data));
  }

  Future<List<ActivityTypeEntity>>? loadActivityTypes(
      {int? page, int? limit, String? search}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(ACTIVITY_TYPES_KEY);
    if (data == null) throw CacheFailure();
    return ActivityTypeEntity.loadActivityTypes(json.decode(data));
  }

  Future<bool>? saveGuestActivity(
      int? page, String? type, List<ActivityEntity> activities) async {
    if (page != null && page > 1) return false;
    return await cache.setString(
        GUEST_ACTIVITY_KEY + (type != null ? ('___' + type) : ''),
        json.encode(activities));
  }

  Future<bool>? saveStaffActivity(
      int? page, String? type, List<ActivityEntity> activities) async {
    if (page != null && page > 1) return false;
    return await cache.setString(
        STAFF_ACTIVITY_KEY + (type != null ? ('___' + type) : ''),
        json.encode(activities));
  }

  Future<bool>? saveStaffs(int? page, result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(STAFFS_KEY, json.encode(result));
  }

  Future<bool>? saveGuests(int? page, result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(GUESTS_KEY, json.encode(result));
  }

  Future<bool>? saveActivityTypes(int? page, result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(ACTIVITY_TYPES_KEY, json.encode(result));
  }
}
