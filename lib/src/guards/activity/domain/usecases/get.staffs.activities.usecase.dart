import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

import '../../../../core/data/pagination.dto.dart';
import '../entities/staff.attendance.entity.dart';

@singleton
class GetStaffsActivityUseCase
    extends UseCase<Pagination<StaffAttendanceEntity>, GetStaffsActivityParam> {
  final IActivityRepository repo;
  GetStaffsActivityUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<StaffAttendanceEntity>>?>? call(
      GetStaffsActivityParam param) {
    return repo.getStaffActivities(
        page: param.page,
        limit: param.limit,
        startTime: param.startTime,
        endTime: param.endTime);
  }
}

class GetStaffsActivityParam extends Equatable {
  final String? type;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? page;
  final int? limit;

  const GetStaffsActivityParam(
      {this.type, this.page, this.limit, this.startTime, this.endTime});

  @override
  List<Object?> get props => [type, startTime, endTime, page, limit];
}
