import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/core/data/pagination.dto.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:rnginfra/src/guards/patroll/domain/repositories/i.patroll.repository.dart';

@singleton
class ListPatrollUseCase
    extends UseCase<Pagination<PatrollEntity>, ListPatrollParam> {
  final IPatrollRepository patrollRepository;

  ListPatrollUseCase({required this.patrollRepository});

  @override
  Future<Either<Failure, Pagination<PatrollEntity>>?>? call(
      ListPatrollParam param) {
    return patrollRepository.listPatroll(page: param.page, limit: param.limit);
  }
}

class ListPatrollParam extends Equatable {
  final int? page;
  final int? limit;
  final DateTime? startTime;
  final DateTime? endTime;
  const ListPatrollParam(
      {required this.page, required this.limit, this.startTime, this.endTime});

  @override
  List<Object?> get props => [page, limit, startTime, endTime];
}
