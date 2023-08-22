import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/domain/entities/visitation.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/core/domain/entities/activity.entity.dart';
import '../repositories/i.visitors.repository.dart';

@singleton
class AddVisitorActivityUseCase
    extends UseCase<VisitationEntity, AddVisitorActivityParam> {
  final IVisitorsRepository repo;
  AddVisitorActivityUseCase({required this.repo});

  @override
  Future<Either<Failure, VisitationEntity>?>? call(
      AddVisitorActivityParam param) {
    return repo.addVisitorActivity(
        entry: param.entry, exit: param.exit, activity: param.activity);
  }
}

class AddVisitorActivityParam extends Equatable {
  final VisitationEntity activity;
  final DateTime entry;
  final DateTime? exit;

  const AddVisitorActivityParam(
      {required this.activity, required this.entry, this.exit});

  @override
  List<Object?> get props => [activity, exit, entry];
}
