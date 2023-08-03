import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/favorites.entity.dart';
import '../repositories/i.favorite.repository.dart';

@lazySingleton
class UnsetFavoriteUsecase
    implements UseCase<WrapperDto, UnsetFavoriteUsecaseParam> {
  final IFavoriteRepository favoriteRepository;

  UnsetFavoriteUsecase({required this.favoriteRepository});

  @override
  Future<Either<Failure, WrapperDto>?>? call(
      {required UnsetFavoriteUsecaseParam param}) {
    return favoriteRepository.unsetFavorite(favorite: param.favorite);
  }
}

class UnsetFavoriteUsecaseParam extends Equatable {
  final FavoriteEntity favorite;
  const UnsetFavoriteUsecaseParam({required this.favorite});

  @override
  List<Object?> get props => [favorite];
}
