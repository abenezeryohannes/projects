import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/resident.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class GetResidentsUseCase
    extends UseCase<Pagination<ResidentEntity>, GetResidentsParam> {
  final IActivityRepository repo;
  GetResidentsUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<ResidentEntity>>?>? call(
      GetResidentsParam param) {
    return repo.getResidents(
        page: param.page, search: param.search, limit: param.limit);
  }
}

class GetResidentsParam extends Equatable {
  final String? search;
  final String? activityType;
  final int? page;
  final int? limit;

  const GetResidentsParam(
      {this.search, this.page, this.limit, this.activityType});

  @override
  List<Object?> get props => [search, activityType, page, limit];
}
