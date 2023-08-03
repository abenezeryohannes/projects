import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/domain/user/repositories/i.user.repository.dart';
import 'package:linko/src/infrastructure/user/dtos/user.dto.dart';

@lazySingleton
class EditUserUsecase
    implements UseCase<WrapperDto<UserEntity>, EditUserUsecaseParam> {
  final IUserRepository userRepository;

  EditUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, WrapperDto<UserEntity>>?>? call(
      {required EditUserUsecaseParam param}) {
    return userRepository.editUser(user: param.user);
  }
}

class EditUserUsecaseParam extends Equatable {
  final UserDto user;
  const EditUserUsecaseParam({required this.user});

  @override
  List<Object?> get props => [user];
}
