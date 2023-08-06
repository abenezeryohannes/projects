import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/domain/user/repositories/i.favorite.repository.dart';
import 'package:linko/src/infrastructure/user/datasources/favorite/favorite.local.datasource.dart';
import 'package:linko/src/infrastructure/user/datasources/favorite/favorite.remote.datasource.dart';

import '../../../appcore/errors/exceptions.dart';
import '../../../appcore/network/network.info.dart';

@LazySingleton(as: IFavoriteRepository)
class FavoriteRepositoryImp extends IFavoriteRepository {
  final FavoriteLocalDataSource localDataSource;
  final FavoriteRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  FavoriteRepositoryImp(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, WrapperDto<FavoriteEntity?>>?>? find(
      {required int companyID}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.find(companyID: companyID);
        if (response == null) return Left(UnExpectedFailure());
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

  @override
  Future<Either<Failure, WrapperDto<FavoriteEntity>>?>? findAll(
      {String? search, int? page, int? limit, int? lastID}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.findAll(
            search: search, page: page, limit: limit, lastID: lastID);
        if (response == null) return Left(UnExpectedFailure());
        if (response.page == 0 && response.datas != null) {
          localDataSource.saveFavorites(response.page, response.datas);
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

  @override
  Future<Either<Failure, WrapperDto<FavoriteEntity>>?>? setFavorite(
      {required CompanyEntity company}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.add(companyID: company.id);
        if (response == null) return Left(UnExpectedFailure());
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

  @override
  Future<Either<Failure, WrapperDto>?>? unsetFavorite(
      {required FavoriteEntity favorite}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.delete(favorite: favorite);
        if (response == null) return Left(UnExpectedFailure());
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
