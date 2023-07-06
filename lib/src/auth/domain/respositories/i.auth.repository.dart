import 'package:dartz/dartz.dart';
import 'package:rnginfra/src/auth/domain/entities/i.firebase.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, IFirebaseAuthEntity>?>? verifyPhoneNumber(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity>?>? resendPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity>?>? confirmPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity>?>? signOut(
      IFirebaseAuthEntity firebaseDto);
}
