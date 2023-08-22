import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class EditStaffAttendanceUseCase
    extends UseCase<StaffActivityEntity, EditStaffAttendanceParam> {
  final IActivityRepository repo;
  EditStaffAttendanceUseCase({required this.repo});

  @override
  Future<Either<Failure, StaffActivityEntity>?>? call(
      EditStaffAttendanceParam param) {
    return repo.editStaffAttendance(
        targetId: param.targetId,
        entranceTime: param.entranceTime,
        exitTime: param.exitTime);
  }
}

class EditStaffAttendanceParam extends Equatable {
  final DateTime? entranceTime;
  final DateTime? exitTime;
  final String targetId;

  const EditStaffAttendanceParam(
      {required this.targetId,
      required this.entranceTime,
      required this.exitTime});

  @override
  List<Object?> get props => [exitTime];
}
