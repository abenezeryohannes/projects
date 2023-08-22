import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class GetGuestsUseCase extends UseCase<List<UserEntity>, GetGuestsParam> {
  final IActivityRepository repo;
  GetGuestsUseCase({required this.repo});

  @override
  Future<Either<Failure, List<UserEntity>>?>? call(GetGuestsParam param) {
    return repo.getGuests(
        page: param.page,
        search: param.search,
        activityType: param.activityType,
        limit: param.limit);
  }
}

class GetGuestsParam extends Equatable {
  final String? search;
  final String? activityType;
  final int? page;
  final int? limit;

  const GetGuestsParam({this.search, this.page, this.limit, this.activityType});

  @override
  List<Object?> get props => [search, activityType, page, limit];
}
