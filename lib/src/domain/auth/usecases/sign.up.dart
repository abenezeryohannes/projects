import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../../user/entities/user.entity.dart';
import '../respositories/i.auth.repository.dart';

@singleton
class SignUp implements UseCase<WrapperDto<UserEntity>, SignUpParam> {
  late IAuthRepository authRepository;
  SignUp({required this.authRepository});

  @override
  Future<Either<Failure, WrapperDto<UserEntity>>?>? call(
      {required SignUpParam param}) {
    return authRepository.signup(phoneNumber: param.phoneNumber);
  }
}

class SignUpParam extends Equatable {
  final String phoneNumber;
  const SignUpParam({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}
