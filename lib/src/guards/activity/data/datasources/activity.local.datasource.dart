import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/core/domain/entities/resident.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/entities/guest.visitation.entity.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/staff.attendance.entity.dart';

@singleton
class ActivityLocalDatasource {
  final SharedPreferences cache;

  const ActivityLocalDatasource({required this.cache});

  static String GUEST_ACTIVITY_KEY = 'GUEST_ACTIVITY_KEY';
  static String STAFF_ACTIVITY_KEY = 'STAFF_ACTIVITY_KEY';

  static String GUESTS_KEY = 'GUESTS_KEY';
  static String STAFFS_KEY = 'STAFFS_KEY';
  static String ACTIVITY_TYPES_KEY = 'ACTIVITY_TYPES_KEY';
  static String RESIDENTS_KEY = 'RESIDENTS_KEY';

  Future<List<GuestVisitationEntity>>? loadGuestActivity(
      {int? page, String? type, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(GUEST_ACTIVITY_KEY + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return GuestVisitationEntity.loadGuestActivities(json.decode(data));
  }

  Future<List<StaffAttendanceEntity>>? loadStaffActivity(
      {int? page, String? type, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(STAFF_ACTIVITY_KEY + (page?.toString() ?? ''));
    if (data == null) throw CacheFailure();
    return StaffAttendanceEntity.loadAttendances(json.decode(data));
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

  Future<List<ResidentEntity>>? loadResidents({int? page, int? limit}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(GUESTS_KEY);
    if (data == null) throw CacheFailure();
    return ResidentEntity.parseMany(json.decode(data));
  }

  Future<List<ActivityTypeEntity>>? loadActivityTypes(
      {int? page, int? limit, String? search}) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(ACTIVITY_TYPES_KEY);
    if (data == null) throw CacheFailure();
    return ActivityTypeEntity.loadActivityTypes(json.decode(data));
  }

  Future<bool>? saveGuestActivity(
      int? page, String? type, List<GuestVisitationEntity> activities) async {
    if (page != null && page > 1) return false;
    return await cache.setString(GUEST_ACTIVITY_KEY + (page?.toString() ?? ''),
        json.encode(activities.map((e) => e.toJson()).toList()));
  }

  Future<bool>? saveStaffActivity(
      int? page, String? type, List<StaffAttendanceEntity> activities) async {
    if (page != null && page > 1) return false;
    return await cache.setString(STAFF_ACTIVITY_KEY + (page?.toString() ?? ''),
        json.encode(activities.map((e) => e.toJson()).toList()));
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

  Future<bool>? saveResidents(int? page, result) async {
    if (page != null && page > 1) return false;
    return await cache.setString(RESIDENTS_KEY, json.encode(result));
  }
}
