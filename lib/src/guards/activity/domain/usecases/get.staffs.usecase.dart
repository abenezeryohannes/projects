import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

import '../../../../auth/domain/entities/user.entity.dart';

@singleton
class GetStaffsUseCase extends UseCase<List<UserEntity>, GetStaffsParam> {
  final IActivityRepository repo;
  GetStaffsUseCase({required this.repo});

  @override
  Future<Either<Failure, List<UserEntity>>?>? call(GetStaffsParam param) {
    return repo.getStaffs(
        page: param.page,
        limit: param.limit,
        search: param.search,
        position: param.position);
  }
}

class GetStaffsParam extends Equatable {
  final String? search;
  final String? position;
  final int? page;
  final int? limit;

  const GetStaffsParam({this.search, this.page, this.limit, this.position});

  @override
  List<Object?> get props => [search, position, page, limit];
}
