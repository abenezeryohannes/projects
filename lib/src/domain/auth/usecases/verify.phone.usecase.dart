import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/i.firebase.entity.dart';
import '../respositories/i.auth.repository.dart';

@singleton
class VerifyPhoneNumberUseCase
    implements UseCase<IFirebaseAuthEntity, VerifyUseCaseParam> {
  late IAuthRepository signInRepository;
  VerifyPhoneNumberUseCase({required this.signInRepository});

  @override
  Future<Either<Failure, IFirebaseAuthEntity>?>? call(
      {required VerifyUseCaseParam param}) {
    return signInRepository.verifyPhoneNumber(param.firebaseDto);
  }
}

class VerifyUseCaseParam extends Equatable {
  final IFirebaseAuthEntity firebaseDto;

  const VerifyUseCaseParam({required this.firebaseDto});

  @override
  List<Object?> get props => [firebaseDto];
}
