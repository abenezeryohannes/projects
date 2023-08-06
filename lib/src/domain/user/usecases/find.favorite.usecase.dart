import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/favorites.entity.dart';
import '../repositories/i.favorite.repository.dart';

@lazySingleton
class FindFavoriteUsecase
    implements UseCase<WrapperDto<FavoriteEntity?>, FindFavoriteUsecaseParam> {
  final IFavoriteRepository favoriteRepository;

  FindFavoriteUsecase({required this.favoriteRepository});

  @override
  Future<Either<Failure, WrapperDto<FavoriteEntity?>>?>? call(
      {required FindFavoriteUsecaseParam param}) {
    return favoriteRepository.find(companyID: param.companyID);
  }
}

class FindFavoriteUsecaseParam extends Equatable {
  final int companyID;
  const FindFavoriteUsecaseParam({required this.companyID});

  @override
  List<Object?> get props => [];
}
