import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/repositories/i.complaint.repository.dart';

@singleton
class GetCommentVotesUseCase
    extends UseCase<List<VoteComplaintEntity>, GetCommentVotesParam> {
  final IComplaintRepository repo;
  GetCommentVotesUseCase({required this.repo});

  @override
  Future<Either<Failure, List<VoteComplaintEntity>>?>? call(
      GetCommentVotesParam param) {
    return repo.getCommentVotes(id: param.id);
  }
}

class GetCommentVotesParam extends Equatable {
  final int id;

  const GetCommentVotesParam({required this.id});

  @override
  List<Object?> get props => [id];
}
