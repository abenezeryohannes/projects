import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/auth/domain/entities/i.firebase.entity.dart';
import 'package:linko/src/core/errors/failure.dart';
import 'package:linko/src/core/usecases/usecase.dart';

import '../respositories/i.auth.repository.dart';

@singleton
class ConfirmPhoneConfirmationCode
    implements UseCase<IFirebaseAuthEntity, ConfirmPhoneConfirmationCodeParam> {
  late IAuthRepository signInRepository;
  ConfirmPhoneConfirmationCode({required this.signInRepository});

  @override
  Future<Either<Failure, IFirebaseAuthEntity>?>? call(param) {
    return signInRepository.confirmPhoneConfirmationCode(param.firebaseDto);
  }
}

class ConfirmPhoneConfirmationCodeParam extends Equatable {
  final IFirebaseAuthEntity firebaseDto;

  const ConfirmPhoneConfirmationCodeParam({required this.firebaseDto});

  @override
  List<Object?> get props => [firebaseDto];
}
