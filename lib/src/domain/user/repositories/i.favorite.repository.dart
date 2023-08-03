import 'package:dartz/dartz.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';

import '../../../appcore/errors/failure.dart';

abstract class IFavoriteRepository {
  Future<Either<Failure, WrapperDto<UserEntity>>?>? setFavorite(
      {required CompanyEntity company});

  Future<Either<Failure, WrapperDto>?>? unsetFavorite(
      {required FavoriteEntity favorite});

  Future<Either<Failure, WrapperDto<List<FavoriteEntity>?>>?>? findFavorites(
      {String? search});
}
