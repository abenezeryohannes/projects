import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import '../../../../core/domain/entities/guest.visitation.entity.dart';
import '../repositories/i.visitors.repository.dart';

@lazySingleton
class GetLocalVisitorActivitiesUseCase extends UseCase<
    Pagination<GuestVisitationEntity>, GetLocalVisitorActivitiesParam> {
  final IVisitorsRepository repo;
  GetLocalVisitorActivitiesUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>? call(
      GetLocalVisitorActivitiesParam param) {
    return repo.getLocalVisitors(
        page: param.page,
        limit: param.limit,
        startTime: param.startTime,
        endTime: param.endTime);
  }
}

class GetLocalVisitorActivitiesParam extends Equatable {
  final String? type;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? page;
  final int? limit;

  const GetLocalVisitorActivitiesParam(
      {this.type, this.page, this.limit, this.startTime, this.endTime});

  @override
  List<Object?> get props => [type, startTime, endTime, page, limit];
}
