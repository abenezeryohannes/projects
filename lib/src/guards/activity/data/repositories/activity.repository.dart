import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/network/network.info.dart';
import 'package:rnginfra/src/guards/activity/data/datasources/activity.local.datasource.dart';
import 'package:rnginfra/src/guards/activity/data/datasources/activity.remote.datasource.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/guest.activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/resident.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

import '../../../../core/data/pagination.dto.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/staff.attendance.entity.dart';

@Singleton(as: IActivityRepository)
class ActivityRepository extends IActivityRepository {
  final INetworkInfo networkInfo;
  final ActivityRemoteDatasource remoteDataSource;
  final ActivityLocalDatasource localDataSource;

  ActivityRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, Pagination<GuestActivityEntity>>?>? getGuestActivities(
      {int? page,
      int? limit,
      String? type,
      DateTime? startTime,
      DateTime? endTime}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.listGuestActivity(
            page: page,
            limit: limit,
            startTime: startTime,
            endTime: endTime,
            type: type);
        if (result == null) {
          throw NoDataException();
        }
        if (result.results.isNotEmpty) {
          await localDataSource.saveGuestActivity(page, type, result.results);
        }
        return Right(result);
      } else {
        final result = await localDataSource.loadGuestActivity(
            page: page, limit: limit, type: type);
        if (result == null) {
          throw CacheException();
        }
        return Right(Pagination<GuestActivityEntity>.fill(results: result));
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<StaffAttendanceEntity>>?>?
      getStaffActivities(
          {int? page,
          int? limit,
          String? type,
          DateTime? startTime,
          DateTime? endTime}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.listStaffActivity(
            page: page, limit: limit, startTime: startTime, endTime: endTime);
        if (result == null) {
          throw NoDataException();
        }
        await localDataSource.saveStaffActivity(page, type, result.results);
        return Right(result);
      } else {
        final result = await localDataSource.loadStaffActivity(
            page: page, limit: limit, type: type);
        if (result == null) {
          throw CacheException();
        }
        return Right(Pagination<StaffAttendanceEntity>.fill(results: result));
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActivityTypeEntity>>?>? getActivityTypes(
      {int? page, int? limit, String? search}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.listActivityTypes(
            page: page, limit: limit, search: search);
        if (result == null) {
          throw NoDataException();
        }
        if (search == null) {
          await localDataSource.saveActivityTypes(page, result);
        }
        return Right(result);
      } else {
        final result = await localDataSource.loadActivityTypes(
            page: page, limit: limit, search: search);
        if (result == null) {
          throw CacheException();
        }
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>?>? getGuests(
      {int? page, int? limit, String? search, String? activityType}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.listGuests(
            page: page,
            limit: limit,
            search: search,
            activityType: activityType);
        if (result == null) {
          throw NoDataException();
        }
        if (search == null && activityType == null) {
          await localDataSource.saveGuests(page, result);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadGuests(page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<UserEntity>>?>? getStaffs(
      {int? page, int? limit, String? search, String? position}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.listStaffs(
            page: page, limit: limit, search: search, position: position);
        if (result == null) {
          throw NoDataException();
        }
        if (search == null && position == null) {
          await localDataSource.saveStaffs(page, result);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadStaffs(page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(Pagination<UserEntity>.fill(results: result));
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StaffActivityEntity>?>? addStaffAttendance(
      {required String targetId, required DateTime time}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.addStaffAttendance(
            targetId: targetId, time: time);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StaffActivityEntity>?>? editStaffAttendance(
      {required String targetId,
      DateTime? entranceTime,
      DateTime? exitTime}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.editStaffAttendance(
            targetId: targetId, entranceTime: entranceTime, exitTime: exitTime);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActivityEntity>?>? addGuestActivity({
    required ActivityEntity activity,
    required DateTime entry,
    required DateTime? exit,
  }) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.addGuestActivity(
            activity: activity, entry: entry, exit: exit);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActivityEntity>?>? editGuestActivity(
      {required String targetId,
      required ActivityEntity activity,
      DateTime? entranceTime,
      DateTime? exitTime}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.editGuestActivity(
            targetId: targetId,
            entranceTime: entranceTime,
            exitTime: exitTime,
            activity: activity);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<ResidentEntity>>?>? getResidents(
      {int? page, int? limit, String? search}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.getResidents(
            page: page, limit: limit, search: search);
        if (result == null) {
          throw NoDataException();
        }
        if (search == null) {
          await localDataSource.saveResidents(page, result);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadResidents(page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(Pagination<ResidentEntity>.fill(results: result));
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<GuestActivityEntity>>?>?
      getLocalGuestActivities(
          {int? page,
          int? limit,
          String? type,
          DateTime? startTime,
          DateTime? endTime}) async {
    try {
      final result = await localDataSource.loadGuestActivity(
          page: page, limit: limit, type: type);
      if (result == null) {
        throw CacheException();
      }
      return Right(Pagination<GuestActivityEntity>.fill(results: result));
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<StaffAttendanceEntity>>?>?
      getLocalStaffActivities(
          {int? page,
          int? limit,
          String? type,
          DateTime? startTime,
          DateTime? endTime}) async {
    try {
      final result = await localDataSource.loadStaffActivity(
          page: page, limit: limit, type: type);
      if (result == null) {
        throw CacheException();
      }
      return Right(Pagination<StaffAttendanceEntity>.fill(results: result));
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
