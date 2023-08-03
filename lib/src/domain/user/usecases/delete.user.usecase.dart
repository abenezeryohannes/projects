import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/domain/user/repositories/i.user.repository.dart';

@lazySingleton
class DeleteUserUsecase implements UseCase<WrapperDto, DeleteUserUsecaseParam> {
  final IUserRepository userRepository;

  DeleteUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, WrapperDto>?>? call(
      {required DeleteUserUsecaseParam param}) {
    return userRepository.deleteUser(user: param.user);
  }
}

class DeleteUserUsecaseParam extends Equatable {
  final UserEntity user;
  const DeleteUserUsecaseParam({required this.user});

  @override
  List<Object?> get props => [user];
}
