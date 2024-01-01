import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/network/network.info.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/file.entity.dart';
import 'package:rnginfra/src/residents/visitors/data/datasources/complaint/complaint.local.datasource.dart';
import 'package:rnginfra/src/residents/visitors/data/datasources/complaint/complaint.remote.datasource.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/category.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/create.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/repositories/i.complaint.repository.dart';
import '../../../../core/data/pagination.dto.dart';
import '../../../../core/errors/exceptions.dart';

@LazySingleton(as: IComplaintRepository)
class ComplaintRepository extends IComplaintRepository {
  final INetworkInfo networkInfo;
  final ComplaintRemoteDatasource remoteDataSource;
  final ComplaintLocalDatasource localDataSource;

  ComplaintRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, Pagination<CategoryEntity>>?> getCategories(
      {int? page, int? limit, String? search}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.getCategories(
            page: page, limit: limit, search: search);
        if (result == null) {
          throw NoDataException();
        }
        if (search == null) {
          await localDataSource.saveCategories(page, result);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadCategories(page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(Pagination<CategoryEntity>.fill(results: result));
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentEntity>?>? addComment(
      {required AddCommentEntity comment}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.addComment(comment: comment);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ComplaintEntity>?>? addComplaint(
      {required CreateComplaintEntity complaint}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result =
            await remoteDataSource.addComplaint(complaint: complaint);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<CommentEntity>>?>? getComments(
      {required String id, int? page, int? limit, String? search}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.getComments(
            id: id, page: page, limit: limit, search: search);
        if (result == null) {
          throw NoDataException();
        }
        if (search == null) {
          await localDataSource.saveComments(result);
        }
        return Right(result);
      } else if (search == null) {
        final result = await localDataSource.loadComments(
            id: id, page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(Pagination<CommentEntity>.fill(results: result));
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<ComplaintEntity>>?> getComplaints(
      {int? page, int? limit, String? search, String? categoryID}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.getComplaints(
            page: page, limit: limit, search: search, categoryID: categoryID);
        if (result == null) {
          throw NoDataException();
        }
        if (search == null) {
          await localDataSource.saveComplaints(page, result);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadComplaints(page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(Pagination<ComplaintEntity>.fill(results: result));
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ComplaintEntity>?>? updateComplaint(
      {required String id, required CreateComplaintEntity complaint}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result =
            await remoteDataSource.editComplaint(id: id, complaint: complaint);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ComplaintEntity>?>? getComplaint(
      {required String id}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.getComplaint(id: id);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FileEntity>?>? uploadFile(
      {required String file}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.uploadFile(fileURL: file);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, VoteComplaintEntity>?>? voteComplaint(
      {required AddVoteComplaintEntity addVote}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.voteComplaint(addVote);
        if (result == null) {
          throw NoDataException();
        }
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VoteComplaintEntity>>?>? getCommentVotes(
      {required int id}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.getCommentVotes(id: id);
        if (result == null) {
          throw NoDataException();
        }
        await localDataSource.saveCommentVotes(result);
        return Right(result);
      } else {
        final result = await localDataSource.loadCommentVotes();
        if (result == null) {
          throw CacheException();
        }
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VoteComplaintEntity>>?>? getComplaintVotes(
      {required int id}) async {
    try {
      if (await networkInfo.isConnected!) {
        final result = await remoteDataSource.getComplaintVotes(id: id);
        if (result == null) {
          throw NoDataException();
        }
        await localDataSource.saveComplaintVotes(result);
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VoteComplaintEntity>>?>? getComplaintsVote(
      {required int? page,
      required int? limit,
      required String? search,
      required bool offline}) async {
    try {
      if (await networkInfo.isConnected! && !offline) {
        final result = await remoteDataSource.getComplaintsVote(
          page: page,
          limit: limit,
          search: search,
        );
        if (result == null) {
          throw NoDataException();
        }
        if (search == null) {
          await localDataSource.saveComplaintsVote(page, result);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadComplaintsVote(page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<ComplaintEntity>>?> getMyComplaints(
      {required int? page,
      required int? limit,
      required String? search,
      required bool offline}) async {
    try {
      if (await networkInfo.isConnected! && !offline) {
        final result = await remoteDataSource.getMyComplaints(
          page: page,
          limit: limit,
          search: search,
        );
        if (result == null) {
          throw NoDataException();
        }
        if (search == null) {
          await localDataSource.saveMyComplaints(page, result);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadMyComplaints(page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VoteComplaintEntity>>?>? getCommentsVote(
      {required int? page,
      required int? limit,
      required String? search,
      required bool offline}) async {
    try {
      if (await networkInfo.isConnected! && !offline) {
        final result = await remoteDataSource.getCommentsVote(
          page: page,
          limit: limit,
          search: search,
        );
        if (result == null) {
          throw NoDataException();
        }
        if (search == null) {
          await localDataSource.saveCommentsVote(page, result);
        }
        return Right(result);
      } else {
        final result =
            await localDataSource.loadCommentsVote(page: page, limit: limit);
        if (result == null) {
          throw CacheException();
        }
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on UnExpectedException catch (e) {
      return Left(UnExpectedFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
