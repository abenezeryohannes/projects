import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/network/network.info.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:linko/src/domain/chat/repositories/i.chat.repository.dart';
import 'package:linko/src/infrastructure/chat/datasources/chat.local.datasource.dart';
import 'package:linko/src/infrastructure/chat/datasources/chat.remote.datasource.dart';

import '../../../appcore/errors/exceptions.dart';

@LazySingleton(as: IChatRepository)
class ChatRepositoryImp extends IChatRepository {
  final ChatLocalDataSource localDataSource;
  final ChatRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  ChatRepositoryImp(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, WrapperDto<ChatEntity>>?>? findAll(
      {int? id, int? limit, int? page}) async {
    try {
      if (await networkInfo.isConnected!) {
        //
        final response =
            await remoteDataSource.findAll(id: id, page: page, limit: limit);
        //
        if (response == null) return Left(UnExpectedFailure());
        //
        localDataSource.saveChat(id == null || id <= 0, response.datas);
        //
        return Right(response);
        //
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
  Future<Either<Failure, WrapperDto>?>? clearAll() async {
    try {
      if (await networkInfo.isConnected!) {
        //
        final response = await remoteDataSource.clearAll();
        //
        if (response == null) return Left(UnExpectedFailure());
        //
        localDataSource.saveChat(true, null);
        //
        return Right(response);
        //
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
