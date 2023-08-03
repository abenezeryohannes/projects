import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/i.firebase.entity.dart';
import '../respositories/i.auth.repository.dart';

@singleton
class VerifyPhoneNumber implements UseCase<IFirebaseAuthEntity, VerifyParam> {
  late IAuthRepository signInRepository;
  VerifyPhoneNumber({required this.signInRepository});

  @override
  Future<Either<Failure, IFirebaseAuthEntity>?>? call(
      {required VerifyParam param}) {
    return signInRepository.verifyPhoneNumber(param.firebaseDto);
  }
}

class VerifyParam extends Equatable {
  final IFirebaseAuthEntity firebaseDto;

  const VerifyParam({required this.firebaseDto});

  @override
  List<Object?> get props => [firebaseDto];
}
