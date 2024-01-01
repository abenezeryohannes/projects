import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/repositories/i.complaint.repository.dart';

@singleton
class AddCommentUseCase extends UseCase<CommentEntity, AddCommentParam> {
  final IComplaintRepository repo;
  AddCommentUseCase({required this.repo});

  @override
  Future<Either<Failure, CommentEntity>?>? call(AddCommentParam param) {
    return repo.addComment(comment: param.comment);
  }
}

class AddCommentParam extends Equatable {
  final AddCommentEntity comment;

  const AddCommentParam({required this.comment});

  @override
  List<Object?> get props => [comment];
}
