import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/core/domain/entities/guest.visitation.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class CheckVisitorPasscodeUseCase extends UseCase<
    Pagination<GuestVisitationEntity>, CheckVisitorPasscodeParam> {
  final IActivityRepository repo;
  CheckVisitorPasscodeUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<GuestVisitationEntity>>?>? call(
      CheckVisitorPasscodeParam param) {
    return repo.checkVisitorPasscode(uuid: param.uuid);
  }
}

class CheckVisitorPasscodeParam extends Equatable {
  final String uuid;

  const CheckVisitorPasscodeParam({required this.uuid});

  @override
  List<Object?> get props => [uuid];
}
