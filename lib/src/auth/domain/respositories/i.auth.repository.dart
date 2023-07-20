import 'package:dartz/dartz.dart';
import 'package:linko/src/auth/domain/entities/i.firebase.entity.dart';
import 'package:linko/src/core/errors/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, IFirebaseAuthEntity>?>? verifyPhoneNumber(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity>?>? resendPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity>?>? confirmPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, IFirebaseAuthEntity>?>? signOut(
      IFirebaseAuthEntity firebaseDto);

  Future<Either<Failure, String>?>? getToken();
}
