import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';

@singleton
class AddPatrollUseCase extends UseCase<PatrollEntity, AddPatrollParam> {
  final IPatrollRepository patrollRepository;

  AddPatrollUseCase({required this.patrollRepository});

  @override
  Future<Either<Failure, PatrollEntity>?>? call(AddPatrollParam param) {
    return patrollRepository.addPatroll(patroll: param.patroll);
  }
}

class AddPatrollParam {
  final PatrollEntity patroll;
  const AddPatrollParam({required this.patroll});
}
