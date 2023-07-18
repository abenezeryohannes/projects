import 'package:dartz/dartz.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.attendance.entity.dart';

import '../../../core/data/pagination.dto.dart';
import '../entities/staff.activity.entity.dart';

abstract class IActivityRepository {
  Future<Either<Failure, Pagination<StaffAttendanceEntity>>?>?
      getStaffActivities({
    int? page,
    int? limit,
    String? type,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<Either<Failure, List<ActivityEntity>>?>? getGuestActivities({
    int? page,
    int? limit,
    String? type,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<Either<Failure, StaffActivityEntity>?>? addStaffAttendance(
      {required String targetId, required DateTime time});

  Future<Either<Failure, Pagination<UserEntity>>?>? getStaffs({
    int? page,
    int? limit,
    String? search,
    String? position,
  });

  Future<Either<Failure, List<UserEntity>>?>? getGuests({
    int? page,
    int? limit,
    String? search,
    String? activityType,
  });

  Future<Either<Failure, List<ActivityTypeEntity>>?>? getActivityTypes(
      {int? page, int? limit, String? search});

  Future<Either<Failure, StaffActivityEntity>?>? editStaffAttendance(
      {required String targetId, DateTime? entranceTime, DateTime? exitTime});
}
