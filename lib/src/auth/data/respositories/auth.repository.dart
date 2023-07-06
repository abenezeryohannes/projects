import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/data/datasources/auth.local.datasource.dart';
import 'package:rnginfra/src/auth/data/datasources/auth.remote.datasource.dart';

import 'package:rnginfra/src/auth/domain/entities/i.firebase.entity.dart';

import 'package:rnginfra/src/core/errors/failure.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/network/network.info.dart';
import '../../domain/respositories/i.auth.repository.dart';

@Singleton(as: IAuthRepository)
class AuthRepository extends IAuthRepository {
  INetworkInfo networkInfo;
  AuthLocalDataSource authLocalDataSource;
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepository(
      {required this.networkInfo,
      required this.authRemoteDataSource,
      required this.authLocalDataSource});

  @override
  Future<Either<Failure, IFirebaseAuthEntity>?>? confirmPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await authRemoteDataSource
            .confirmPhoneConfirmationCode(firebaseDto);
        if (result == null || result.user == null) {
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
  Future<Either<Failure, IFirebaseAuthEntity>?>? resendPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto) async {
    try {
      if (await networkInfo.isConnected!) {
        final result =
            await authRemoteDataSource.verifyPhoneNumber(firebaseDto, true);
        if (result == null) {
          throw UnExpectedException();
        }
        result.user = FirebaseAuth.instance.currentUser;
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
  Future<Either<Failure, IFirebaseAuthEntity>?>? signOut(
      IFirebaseAuthEntity firebaseDto) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await authRemoteDataSource.signOut(firebaseDto);
        if (result == null || !result) {
          throw UnExpectedException();
        }
        firebaseDto.signOut();

        return Right(firebaseDto);
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
  Future<Either<Failure, IFirebaseAuthEntity>?>? verifyPhoneNumber(
      IFirebaseAuthEntity firebaseDto) async {
    try {
      if ((await networkInfo.isConnected!)) {
        final result =
            await authRemoteDataSource.verifyPhoneNumber(firebaseDto, false);
        if (result == null) {
          throw UnExpectedException();
        }
        result.user = FirebaseAuth.instance.currentUser;
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
}
