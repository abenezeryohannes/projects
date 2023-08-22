import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';

@singleton
class EditPatrollUseCase extends UseCase<PatrollEntity, EditPatrollParam> {
  final IPatrollRepository patrollRepository;

  EditPatrollUseCase({required this.patrollRepository});

  @override
  Future<Either<Failure, PatrollEntity>?>? call(EditPatrollParam param) {
    return patrollRepository.editPatroll(patroll: param.patroll, id: param.id);
  }
}

class EditPatrollParam {
  final PatrollEntity patroll;
  final int id;
  const EditPatrollParam(this.id, {required this.patroll});
}
