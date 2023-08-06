import 'package:dartz/dartz.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';

import '../../../appcore/errors/failure.dart';

abstract class IFavoriteRepository {
  Future<Either<Failure, WrapperDto<FavoriteEntity>>?>? setFavorite(
      {required CompanyEntity company});

  Future<Either<Failure, WrapperDto>?>? unsetFavorite(
      {required FavoriteEntity favorite});

  Future<Either<Failure, WrapperDto<FavoriteEntity?>>?>? find(
      {required int companyID});

  Future<Either<Failure, WrapperDto<FavoriteEntity>>?>? findAll(
      {String? search, int? page, int? limit, int? lastID});
}
