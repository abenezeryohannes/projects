import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/core/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class AddGuestActivityUseCase
    extends UseCase<ActivityEntity, AddGuestActivityParam> {
  final IActivityRepository repo;
  AddGuestActivityUseCase({required this.repo});

  @override
  Future<Either<Failure, ActivityEntity>?>? call(AddGuestActivityParam param) {
    return repo.addGuestActivity(
        entry: param.entry, exit: param.exit, activity: param.activity);
  }
}

class AddGuestActivityParam extends Equatable {
  final ActivityEntity activity;
  final DateTime entry;
  final DateTime? exit;

  const AddGuestActivityParam(
      {required this.activity, required this.entry, this.exit});

  @override
  List<Object?> get props => [activity, exit, entry];
}
