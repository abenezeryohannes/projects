import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import '../../repositories/i.complaint.repository.dart';

@singleton
class GetComplaintVotesUseCase
    extends UseCase<List<VoteComplaintEntity>, GetComplaintVotesParam> {
  final IComplaintRepository repo;
  GetComplaintVotesUseCase({required this.repo});

  @override
  Future<Either<Failure, List<VoteComplaintEntity>>?>? call(
      GetComplaintVotesParam param) {
    return repo.getComplaintVotes(id: param.id);
  }
}

class GetComplaintVotesParam extends Equatable {
  final int id;

  const GetComplaintVotesParam({required this.id});

  @override
  List<Object?> get props => [id];
}
