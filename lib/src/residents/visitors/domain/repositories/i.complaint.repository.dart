import 'package:dartz/dartz.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/category.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';

import '../../../../guards/activity/domain/entities/file.entity.dart';
import '../entities/create.complaint.entity.dart';

abstract class IComplaintRepository {
  Future<Either<Failure, Pagination<CategoryEntity>>?> getCategories(
      {int? page, int? limit, String? search});

  Future<Either<Failure, Pagination<ComplaintEntity>>?> getComplaints(
      {int? page, int? limit, String? search, String? categoryID});

  Future<Either<Failure, ComplaintEntity>?>? addComplaint(
      {required CreateComplaintEntity complaint});

  Future<Either<Failure, ComplaintEntity>?>? updateComplaint(
      {required String id, required CreateComplaintEntity complaint});

  Future<Either<Failure, CommentEntity>?>? addComment(
      {required AddCommentEntity comment});

  Future<Either<Failure, Pagination<CommentEntity>>?>? getComments(
      {required String id, int? page, int? limit, String? search});

  Future<Either<Failure, FileEntity>?>? uploadFile({required String file});

  Future<Either<Failure, ComplaintEntity>?>? getComplaint({required String id});

  Future<Either<Failure, VoteComplaintEntity>?>? voteComplaint(
      {required AddVoteComplaintEntity addVote});

  Future<Either<Failure, Pagination<ComplaintEntity>>?> getMyComplaints(
      {required int? page,
      required int? limit,
      required String? search,
      required bool offline});

  Future<Either<Failure, List<VoteComplaintEntity>>?>? getComplaintsVote(
      {required int? page,
      required int? limit,
      required String? search,
      required bool offline});

  Future<Either<Failure, List<VoteComplaintEntity>>?>? getCommentsVote(
      {required int? page,
      required int? limit,
      required String? search,
      required bool offline});

  Future<Either<Failure, List<VoteComplaintEntity>>?>? getComplaintVotes(
      {required int id});

  Future<Either<Failure, List<VoteComplaintEntity>>?>? getCommentVotes(
      {required int id});
}
