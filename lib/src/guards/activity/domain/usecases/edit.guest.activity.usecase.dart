import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class EditGuestActivityUseCase
    extends UseCase<ActivityEntity, EditGuestActivityParam> {
  final IActivityRepository repo;
  EditGuestActivityUseCase({required this.repo});

  @override
  Future<Either<Failure, ActivityEntity>?>? call(EditGuestActivityParam param) {
    return repo.editGuestActivity(
        targetId: param.targetId,
        entranceTime: param.entranceTime,
        exitTime: param.exitTime,
        activity: param.activity);
  }
}

class EditGuestActivityParam extends Equatable {
  final DateTime? entranceTime;
  final DateTime? exitTime;
  final String targetId;
  final ActivityEntity activity;

  const EditGuestActivityParam(
      {required this.targetId,
      required this.activity,
      required this.entranceTime,
      required this.exitTime});

  @override
  List<Object?> get props => [exitTime];
}
