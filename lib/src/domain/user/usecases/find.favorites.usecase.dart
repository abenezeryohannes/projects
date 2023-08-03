import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/favorites.entity.dart';
import '../repositories/i.favorite.repository.dart';

@lazySingleton
class AddFavoriteUsecase
    implements
        UseCase<WrapperDto<List<FavoriteEntity>?>, FindFavoriteUsecaseParam> {
  final IFavoriteRepository favoriteRepository;

  AddFavoriteUsecase({required this.favoriteRepository});

  @override
  Future<Either<Failure, WrapperDto<List<FavoriteEntity>?>>?>? call(
      {required FindFavoriteUsecaseParam param}) {
    return favoriteRepository.findFavorites(search: param.search);
  }
}

class FindFavoriteUsecaseParam extends Equatable {
  final String? search;
  const FindFavoriteUsecaseParam({this.search});

  @override
  List<Object?> get props => [];
}
