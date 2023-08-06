import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../../user/entities/user.entity.dart';
import '../respositories/i.auth.repository.dart';

@singleton
class SignUpUseCase
    implements UseCase<WrapperDto<UserEntity>, SignUpUseCaseParam> {
  late IAuthRepository authRepository;
  SignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, WrapperDto<UserEntity>>?>? call(
      {required SignUpUseCaseParam param}) {
    return authRepository.signup(phoneNumber: param.phoneNumber);
  }
}

class SignUpUseCaseParam extends Equatable {
  final String phoneNumber;
  const SignUpUseCaseParam({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}
