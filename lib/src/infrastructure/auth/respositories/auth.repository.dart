import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';

import '../../../appcore/errors/failure.dart';

import '../../../appcore/errors/exceptions.dart';
import '../../../appcore/network/network.info.dart';
import '../../../domain/auth/entities/i.firebase.entity.dart';
import '../../../domain/auth/respositories/i.auth.repository.dart';
import '../../../domain/user/entities/user.entity.dart';
import '../datasources/auth.local.datasource.dart';
import '../datasources/auth.remote.datasource.dart';

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
  Future<Either<Failure, IFirebaseAuthEntity?>?>? signOut(
      IFirebaseAuthEntity? firebaseDto) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await authRemoteDataSource.signOut(firebaseDto);
        if (result == null || !result) {
          throw UnExpectedException();
        }
        firebaseDto?.signOut();

        GetStorage().write('UID', null);
        GetStorage().write('token', null);
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

  @override
  Future<Either<Failure, WrapperDto<UserEntity>>?>? signup(
      {required String phoneNumber}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result =
            await authRemoteDataSource.signup(phoneNumber: phoneNumber);
        if (result == null) {
          throw UnExpectedException();
        }
        GetStorage().write('UID', result.data?.UID);
        if ((result.data as UserEntity).tokens?[0].token != null) {
          GetStorage()
              .write('token', (result.data as UserEntity).tokens![0].token);
        }
        if (result.success && result.data != null) {
          authLocalDataSource.saveUser(result.data!);
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
      print(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }
}
