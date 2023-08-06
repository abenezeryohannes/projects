import 'package:dartz/dartz.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';

import '../../user/entities/user.entity.dart';
import '../entities/i.firebase.entity.dart';

abstract class IAuthRepository {
  Future<Either<Failure, IFirebaseAuthEntity>?>? verifyPhoneNumber(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity>?>? resendPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity>?>? confirmPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity?>?>? signOut(
      IFirebaseAuthEntity? firebaseDto);

  Future<Either<Failure, WrapperDto<UserEntity>>?>? signup(
      {required String phoneNumber});
}
