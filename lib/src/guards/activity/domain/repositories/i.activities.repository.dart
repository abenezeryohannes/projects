import 'package:dartz/dartz.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';

abstract class IActivityRepository {
  Future<Either<Failure, List<ActivityEntity>>?>? getStaffActivities({
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

  Future<Either<Failure, List<UserEntity>>?>? getStaffs({
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
}
