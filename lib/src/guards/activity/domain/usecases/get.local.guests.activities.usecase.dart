import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

import '../entities/guest.activity.entity.dart';

@singleton
class GetGuestsActivitiesUseCase
    extends UseCase<Pagination<GuestActivityEntity>, GetGuestActivityParam> {
  final IActivityRepository repo;
  GetGuestsActivitiesUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<GuestActivityEntity>>?>? call(
      GetGuestActivityParam param) {
    return repo.getGuestActivities(
        page: param.page,
        limit: param.limit,
        startTime: param.startTime,
        endTime: param.endTime);
  }
}

class GetGuestActivityParam extends Equatable {
  final String? type;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? page;
  final int? limit;

  const GetGuestActivityParam(
      {this.type, this.page, this.limit, this.startTime, this.endTime});

  @override
  List<Object?> get props => [type, startTime, endTime, page, limit];
}
