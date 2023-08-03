import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';

import '../../../appcore/errors/exceptions.dart';
import '../../../appcore/network/network.info.dart';
import '../../../domain/company/repositories/i.tag.repository.dart';
import '../datasources/tag/tag.local.datasource.dart';
import '../datasources/tag/tag.remote.datasource.dart';

@LazySingleton(as: ITagRepository)
class TagRepositoryImp extends ITagRepository {
  final TagLocalDataSource localDataSource;
  final TagRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  TagRepositoryImp(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, WrapperDto<TagEntity>>?>? findAll(
      {String? search}) async {
    try {
      if (await networkInfo.isConnected! || true) {
        final response = await remoteDataSource.findAll(search: search);
        if (response == null) return Left(UnExpectedFailure());
        if (response.page == 0 && response.datas != null) {
          localDataSource.saveTags(response.page, response.datas);
        }
        return Right(response);
      } else {
        throw NetworkFailure();
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
