import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/i.firebase.entity.dart';
import '../respositories/i.auth.repository.dart';

@singleton
class ConfirmPhoneConfirmationCodeUseCase
    implements
        UseCase<IFirebaseAuthEntity, ConfirmPhoneConfirmationCodeUseCaseParam> {
  late IAuthRepository signInRepository;
  ConfirmPhoneConfirmationCodeUseCase({required this.signInRepository});

  @override
  Future<Either<Failure, IFirebaseAuthEntity>?>? call(
      {required ConfirmPhoneConfirmationCodeUseCaseParam param}) {
    return signInRepository.confirmPhoneConfirmationCode(param.firebaseDto);
  }
}

class ConfirmPhoneConfirmationCodeUseCaseParam extends Equatable {
  final IFirebaseAuthEntity firebaseDto;

  const ConfirmPhoneConfirmationCodeUseCaseParam({required this.firebaseDto});

  @override
  List<Object?> get props => [firebaseDto];
}
