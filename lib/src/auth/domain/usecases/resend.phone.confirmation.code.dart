import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/i.firebase.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';

import '../respositories/i.auth.repository.dart';

@singleton
class ResendPhoneConfirmationCode
    implements UseCase<IFirebaseAuthEntity, ResendPhoneConfirmationCodeParam> {
  late IAuthRepository signInRepository;
  ResendPhoneConfirmationCode({required this.signInRepository});

  @override
  Future<Either<Failure, IFirebaseAuthEntity>?>? call(param) {
    return signInRepository.resendPhoneConfirmationCode(param.firebaseDto);
  }
}

class ResendPhoneConfirmationCodeParam extends Equatable {
  final IFirebaseAuthEntity firebaseDto;

  const ResendPhoneConfirmationCodeParam({required this.firebaseDto});

  @override
  List<Object?> get props => [firebaseDto];
}
