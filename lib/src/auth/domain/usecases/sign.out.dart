import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/i.firebase.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';

import '../respositories/i.auth.repository.dart';

@singleton
class SignOut implements UseCase<IFirebaseAuthEntity, SignOutParam> {
  late IAuthRepository signInRepository;
  SignOut({required this.signInRepository});

  @override
  Future<Either<Failure, IFirebaseAuthEntity>?>? call(param) {
    return signInRepository.signOut(param.firebaseDto);
  }
}

class SignOutParam extends Equatable {
  final IFirebaseAuthEntity firebaseDto;

  const SignOutParam({required this.firebaseDto});

  @override
  List<Object?> get props => [firebaseDto];
}
