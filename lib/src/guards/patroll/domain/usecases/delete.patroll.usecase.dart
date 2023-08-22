import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';

@singleton
class DeletePatrollUseCase extends UseCase<bool, DeletePatrollParam> {
  final IPatrollRepository patrollRepository;

  DeletePatrollUseCase({required this.patrollRepository});

  @override
  Future<Either<Failure, bool>?>? call(DeletePatrollParam param) {
    return patrollRepository.deletePatroll(patroll: param.patroll);
  }
}

class DeletePatrollParam {
  final PatrollEntity patroll;
  const DeletePatrollParam({required this.patroll});
}
