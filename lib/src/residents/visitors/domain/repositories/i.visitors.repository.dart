import 'package:dartz/dartz.dart';
import 'package:rnginfra/src/core/domain/entities/guest.visitation.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';

import '../../../../core/data/pagination.dto.dart';
import '../../../../core/domain/entities/visitation.entity.dart';

abstract class IVisitorsRepository {
  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>?
      getVisitorActivities({
    int? page,
    int? limit,
    String? type,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>?
      getLocalVisitors({
    int? page,
    int? limit,
    String? type,
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<Either<Failure, VisitationEntity>?>? addVisitorActivity(
      {required VisitationEntity activity,
      required DateTime entry,
      required DateTime? exit});

  Future<Either<Failure, VisitationEntity>?>? editVisitorActivity(
      {required String targetId,
      required VisitationEntity activity,
      DateTime? entranceTime,
      DateTime? exitTime});
}
