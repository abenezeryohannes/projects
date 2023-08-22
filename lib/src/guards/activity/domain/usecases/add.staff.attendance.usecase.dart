import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class AddStaffAttendanceUseCase
    extends UseCase<StaffActivityEntity, AddStaffAttendanceParam> {
  final IActivityRepository repo;
  AddStaffAttendanceUseCase({required this.repo});

  @override
  Future<Either<Failure, StaffActivityEntity>?>? call(
      AddStaffAttendanceParam param) {
    return repo.addStaffAttendance(targetId: param.targetId, time: param.time);
  }
}

class AddStaffAttendanceParam extends Equatable {
  final String targetId;
  final DateTime time;

  const AddStaffAttendanceParam({required this.targetId, required this.time});

  @override
  List<Object?> get props => [targetId, time];
}
