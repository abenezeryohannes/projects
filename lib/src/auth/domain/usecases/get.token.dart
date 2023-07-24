import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';

import '../respositories/i.auth.repository.dart';

@singleton
class GetToken implements UseCase<String, GetTokenParam> {
  late IAuthRepository authRepository;
  GetToken({required this.authRepository});

  @override
  Future<Either<Failure, String>?>? call(param) {
    return authRepository.getToken();
  }
}

class GetTokenParam extends Equatable {
  const GetTokenParam();

  @override
  List<Object?> get props => [];
}
