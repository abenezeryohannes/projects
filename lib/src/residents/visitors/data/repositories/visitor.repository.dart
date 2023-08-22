import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/network/network.info.dart';
import 'package:rnginfra/src/residents/visitors/data/datasources/visitor.local.datasource.dart';
import 'package:rnginfra/src/residents/visitors/data/datasources/visitor.remote.datasource.dart';
import 'package:rnginfra/src/residents/visitors/domain/repositories/i.visitors.repository.dart';
import '../../../../core/data/pagination.dto.dart';
import '../../../../core/domain/entities/guest.visitation.entity.dart';
import '../../../../core/domain/entities/resident.entity.dart';
import '../../../../core/domain/entities/visitation.entity.dart';
import '../../../../core/errors/exceptions.dart';

@LazySingleton(as: IVisitorsRepository)
class VisitorRepository extends IVisitorsRepository {
  final INetworkInfo networkInfo;
  final VisitorRemoteDatasource remoteDataSource;
  final VisitorLocalDatasource localDataSource;

  VisitorRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>?
      getVisitorActivities(
          {int? page,
          int? limit,
          String? type,
          DateTime? startTime,
          DateTime? endTime}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.listVisitorActvities(
            page: page,
            limit: limit,
            startTime: startTime,
            endTime: endTime,
            type: type);
        if (result == null) {
          throw NoDataException();
        }
        if (result.results.isNotEmpty) {
          await localDataSource.saveVisitorActivities(
              page, type, result.results);
        }
        return Right(result);
      } else {
        final result = await localDataSource.loadVisitors(
            page: page, limit: limit, type: type);
        if (result == null) {
          throw CacheException();
        }
        return Right(Pagination<GuestVisitationEntity>.fill(results: result));
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
  Future<Either<Failure, VisitationEntity>?>? addVisitorActivity({
    required VisitationEntity activity,
    required DateTime entry,
    required DateTime? exit,
  }) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.addVisitorActivity(
            visitation: activity, entry: entry, exit: exit);
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
  Future<Either<Failure, VisitationEntity>?>? editVisitorActivity(
      {required String targetId,
      required VisitationEntity activity,
      DateTime? entranceTime,
      DateTime? exitTime}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.editVisitorActivity(
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
  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>? getLocalVisitors(
      {int? page,
      int? limit,
      String? type,
      DateTime? startTime,
      DateTime? endTime}) async {
    try {
      final result = await localDataSource.loadVisitors(
          page: page, limit: limit, type: type);
      if (result == null) {
        throw CacheException();
      }
      return Right(Pagination<GuestVisitationEntity>.fill(results: result));
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
