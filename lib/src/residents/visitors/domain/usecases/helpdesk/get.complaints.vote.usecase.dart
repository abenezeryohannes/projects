import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import '../../repositories/i.complaint.repository.dart';

@singleton
class GetComplaintsVoteUseCase
    extends UseCase<List<VoteComplaintEntity>, GetComplaintsVoteParam> {
  final IComplaintRepository repo;
  GetComplaintsVoteUseCase({required this.repo});

  @override
  Future<Either<Failure, List<VoteComplaintEntity>>?>? call(
      GetComplaintsVoteParam param) {
    return repo.getComplaintsVote(
        page: param.page,
        search: param.search,
        limit: param.limit,
        offline: param.offline);
  }
}

class GetComplaintsVoteParam extends Equatable {
  final String? search;
  final int? page;
  final int? limit;
  final bool offline;

  const GetComplaintsVoteParam(
      {this.search, this.page, this.limit, this.offline = false});

  @override
  List<Object?> get props => [search, page, limit];
}
