import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';

import '../repositories/i.user.repository.dart';

@lazySingleton
class GetUserUsecase
    implements UseCase<WrapperDto<UserEntity?>, GetUserUsecaseNoParam> {
  final IUserRepository userRepository;

  GetUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, WrapperDto<UserEntity?>>?>? call(
      {required GetUserUsecaseNoParam param}) {
    return userRepository.getUser(local: param.local);
  }
}

class GetUserUsecaseNoParam extends Equatable {
  final bool local;
  const GetUserUsecaseNoParam({this.local = true});

  @override
  List<Object?> get props => [];
}
