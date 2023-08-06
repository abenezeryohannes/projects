import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/domain/user/repositories/i.user.repository.dart';
import 'package:linko/src/infrastructure/user/dtos/user.dto.dart';

import '../../../appcore/errors/exceptions.dart';
import '../../../appcore/network/network.info.dart';
import '../datasources/user/user.local.datasource.dart';
import '../datasources/user/user.remote.datasource.dart';

@LazySingleton(as: IUserRepository)
class UserRepositoryImp extends IUserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  UserRepositoryImp(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, WrapperDto>?>? deleteUser(
      {required UserEntity user}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.delete();
        if (response.data != null) {
          localDataSource.removeUser();
        }
        return Right(response);
      } else {
        throw NetworkFailure();
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
  Future<Either<Failure, WrapperDto<UserEntity>>?>? editUser(
      {required UserDto user}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.edit(userDto: user);
        if (response.data != null) {
          localDataSource.saveUser(response.data!);
        } else {
          throw ServerFailure(message: response.message);
        }
        return Right(response);
      } else {
        throw NetworkFailure();
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
  Future<Either<Failure, WrapperDto<UserEntity?>>?>? getUser(
      {required bool local}) async {
    try {
      if (local) {
        final result = await localDataSource.loadUser();
        if (result != null) {
          return Right(WrapperDto(statusCode: 200, data: result));
        }
      }
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.find();
        if (response.data != null) {
          localDataSource.saveUser(response.data!);
        }
        return Right(response);
      } else {
        throw NetworkFailure();
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
