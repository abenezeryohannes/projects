import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import '../../repositories/i.complaint.repository.dart';

@singleton
class GetCommentsUseCase
    extends UseCase<Pagination<CommentEntity>, GetCommentsParam> {
  final IComplaintRepository repo;
  GetCommentsUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<CommentEntity>>?>? call(
      GetCommentsParam param) {
    return repo.getComments(
        id: param.id,
        search: param.search,
        page: param.page,
        limit: param.limit);
  }
}

class GetCommentsParam extends Equatable {
  final String id;
  final String? search;
  final int? page;
  final int? limit;
  const GetCommentsParam(
      {required this.id, this.search, this.page, this.limit});

  @override
  List<Object?> get props => [id];
}
