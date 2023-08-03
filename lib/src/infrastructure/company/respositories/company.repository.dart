import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/company/repositories/i.company.repository.dart';
import 'package:linko/src/infrastructure/company/dto/company.dto.dart';

import '../../../appcore/errors/exceptions.dart';
import '../../../appcore/network/network.info.dart';
import '../datasources/company/company.local.datasource.dart';
import '../datasources/company/company.remote.datasource.dart';

@LazySingleton(as: ICompanyRepository)
class CompanyRepositoryImp extends ICompanyRepository {
  final CompanyLocalDataSource localDataSource;
  final CompanyRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  CompanyRepositoryImp(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? addCompany(
      {required CompanyDto companyDto}) async {
    try {
      if (await networkInfo.isConnected! || true) {
        final response = await remoteDataSource.add(companyDto: companyDto);
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
  Future<Either<Failure, WrapperDto>?>? deleteCompany(
      {required CompanyEntity company}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.delete(company: company);
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
  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? editCompany(
      {required CompanyDto companyDto}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.edit(companyDto: companyDto);
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
  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? findCompanies(
      {String? search}) async {
    try {
      if (await networkInfo.isConnected!) {
        final response = await remoteDataSource.findAll(search: search);
        if (response == null) return Left(UnExpectedFailure());
        if (response.page == 0 && response.datas != null) {
          localDataSource.saveCompanies(response.page, response.datas);
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
