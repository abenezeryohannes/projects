import 'package:dartz/dartz.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/infrastructure/user/dtos/user.dto.dart';

import '../../../appcore/errors/failure.dart';

abstract class IUserRepository {
  Future<Either<Failure, WrapperDto<UserEntity>>?>? editUser(
      {required UserDto user});

  Future<Either<Failure, WrapperDto>?>? deleteUser({required UserEntity user});

  Future<Either<Failure, WrapperDto<UserEntity?>>?>? getUser(
      {required bool local});
}
