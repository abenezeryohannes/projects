import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/guards/core/data/pager.dto.dart';
import 'package:rnginfra/src/guards/patroll/data/dtos/add.patroll.dto.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';
import 'package:rnginfra/src/guards/patroll/data/datasources/patroll.local.data.source.dart';
import 'package:rnginfra/src/guards/patroll/data/datasources/patroll.remote.data.source.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network.info.dart';
import '../../../core/data/pagination.dto.dart';

@Singleton(as: IPatrollRepository)
class PatrollRepository extends IPatrollRepository {
  INetworkInfo networkInfo;
  PatrollLocalDataSource localDataSource;
  PatrollRemoteDataSource remoteDataSource;

  PatrollRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, bool>?>? addPatroll(
      {required AddPatrollDto patroll}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.addPatroll(patroll: patroll);
        if (result == null) {
          throw UnExpectedException();
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
  Future<Either<Failure, bool>?>? deletePatroll(
      {required PatrollEntity patroll}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.deletePatroll(patroll: patroll);
        if (result == null) {
          throw UnExpectedException();
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
  Future<Either<Failure, PatrollEntity>?>? editPatroll(
      {required PatrollEntity patroll, required int id}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result =
            await remoteDataSource.editPatroll(id: id, patroll: patroll);
        if (result == null) {
          throw UnExpectedException();
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
  Future<Either<Failure, Pagination<PatrollEntity>>?>? listPatroll(
      {int? page, int? limit, DateTime? startTime, DateTime? endTime}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.listPatroll(
            page: page, limit: limit, startTime: startTime, endTime: endTime);
        if (result == null) {
          throw NoDataException();
        }
        if (result.pager.current_page <= 1) {
          await localDataSource.savePatroll(page, result.results);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadPatrolls(page: page, limit: limit);
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
}
