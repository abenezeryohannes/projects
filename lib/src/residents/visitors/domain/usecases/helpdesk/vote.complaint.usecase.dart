import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import '../../repositories/i.complaint.repository.dart';

@singleton
class VoteComplaintUseCase
    extends UseCase<VoteComplaintEntity, AddVoteComplaintParam> {
  final IComplaintRepository repo;
  VoteComplaintUseCase({required this.repo});

  @override
  Future<Either<Failure, VoteComplaintEntity>?>? call(
      AddVoteComplaintParam param) {
    return repo.voteComplaint(addVote: param.addVote);
  }
}

class AddVoteComplaintParam extends Equatable {
  final AddVoteComplaintEntity addVote;

  const AddVoteComplaintParam({required this.addVote});

  @override
  List<Object?> get props => [id, addVote];
}
