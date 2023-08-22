import 'package:dartz/dartz.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/domain/entities/guest.visitation.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/core/domain/entities/resident.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/file.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.attendance.entity.dart';

import '../../../../core/data/pagination.dto.dart';
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

  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>?
      getGuestActivities({
    int? page,
    int? limit,
    String? type,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<Either<Failure, Pagination<StaffAttendanceEntity>>?>?
      getLocalStaffActivities({
    int? page,
    int? limit,
    String? type,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>?
      getLocalGuestActivities({
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

  Future<Either<Failure, Pagination<ResidentEntity>>?>? getResidents({
    int? page,
    int? limit,
    String? search,
  });

  Future<Either<Failure, List<ActivityTypeEntity>>?>? getActivityTypes(
      {int? page, int? limit, String? search});

  Future<Either<Failure, StaffActivityEntity>?>? editStaffAttendance(
      {required String targetId, DateTime? entranceTime, DateTime? exitTime});

  Future<Either<Failure, ActivityEntity>?>? addGuestActivity(
      {required ActivityEntity activity,
      required DateTime entry,
      required DateTime? exit});

  Future<Either<Failure, ActivityEntity>?>? editGuestActivity(
      {required String targetId,
      required ActivityEntity activity,
      DateTime? entranceTime,
      DateTime? exitTime});

  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>?
      checkVisitorPasscode({required String uuid});

  Future<Either<Failure, FileEntity>?>? uploadFile({required String file});
}
