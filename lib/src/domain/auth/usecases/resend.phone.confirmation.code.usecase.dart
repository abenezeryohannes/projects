import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/i.firebase.entity.dart';
import '../respositories/i.auth.repository.dart';

@singleton
class ResendPhoneConfirmationCodeUseCase
    implements
        UseCase<IFirebaseAuthEntity, ResendPhoneConfirmationCodeUseCaseParam> {
  late IAuthRepository signInRepository;
  ResendPhoneConfirmationCodeUseCase({required this.signInRepository});

  @override
  Future<Either<Failure, IFirebaseAuthEntity>?>? call({required param}) {
    return signInRepository.resendPhoneConfirmationCode(param.firebaseDto);
  }
}

class ResendPhoneConfirmationCodeUseCaseParam extends Equatable {
  final IFirebaseAuthEntity firebaseDto;

  const ResendPhoneConfirmationCodeUseCaseParam({required this.firebaseDto});

  @override
  List<Object?> get props => [firebaseDto];
}
