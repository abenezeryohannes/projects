import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/repositories/i.visitors.repository.dart';

import '../../../../core/domain/entities/visitation.entity.dart';

@singleton
class EditVisitorActivityUseCase
    extends UseCase<VisitationEntity, EditVisitorActivityParam> {
  final IVisitorsRepository repo;
  EditVisitorActivityUseCase({required this.repo});

  @override
  Future<Either<Failure, VisitationEntity>?>? call(
      EditVisitorActivityParam param) {
    return repo.editVisitorActivity(
        targetId: param.targetId,
        entranceTime: param.entranceTime,
        exitTime: param.exitTime,
        activity: param.activity);
  }
}

class EditVisitorActivityParam extends Equatable {
  final DateTime? entranceTime;
  final DateTime? exitTime;
  final String targetId;
  final VisitationEntity activity;

  const EditVisitorActivityParam(
      {required this.targetId,
      required this.activity,
      required this.entranceTime,
      required this.exitTime});

  @override
  List<Object?> get props => [exitTime];
}
