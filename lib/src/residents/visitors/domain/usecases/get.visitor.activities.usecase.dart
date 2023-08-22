import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import '../../../../core/domain/entities/guest.visitation.entity.dart';
import '../repositories/i.visitors.repository.dart';

@singleton
class GetVisitorsActivitiesUseCase extends UseCase<
    Pagination<GuestVisitationEntity>, GetVisitorsActivityParam> {
  final IVisitorsRepository repo;
  GetVisitorsActivitiesUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>? call(
      GetVisitorsActivityParam param) {
    return repo.getVisitorActivities(
        page: param.page,
        startTime: param.startTime,
        endTime: param.endTime,
        limit: param.limit);
  }
}

class GetVisitorsActivityParam extends Equatable {
  final DateTime? startTime;
  final DateTime? endTime;
  final int? page;
  final int? limit;

  const GetVisitorsActivityParam(
      {this.startTime, this.page, this.limit, this.endTime});

  @override
  List<Object?> get props => [startTime, endTime, page, limit];
}
