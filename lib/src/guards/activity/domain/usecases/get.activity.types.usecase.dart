import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class GetActivityTypesUseCase
    extends UseCase<List<ActivityTypeEntity>, GetActivityTypeParam> {
  final IActivityRepository repo;
  GetActivityTypesUseCase({required this.repo});

  @override
  Future<Either<Failure, List<ActivityTypeEntity>>?>? call(
      GetActivityTypeParam param) {
    return repo.getActivityTypes(
        page: param.page, limit: param.limit, search: param.search);
  }
}

class GetActivityTypeParam extends Equatable {
  final String? search;
  final int? page;
  final int? limit;

  const GetActivityTypeParam({this.search, this.page, this.limit});

  @override
  List<Object?> get props => [search, page, limit];
}
