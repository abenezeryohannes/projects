import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/favorites.entity.dart';
import '../repositories/i.favorite.repository.dart';

@lazySingleton
class FindFavoritesUsecase
    implements UseCase<WrapperDto<FavoriteEntity>, FindFavoritesUsecaseParam> {
  final IFavoriteRepository favoriteRepository;

  FindFavoritesUsecase({required this.favoriteRepository});

  @override
  Future<Either<Failure, WrapperDto<FavoriteEntity>>?>? call(
      {required FindFavoritesUsecaseParam param}) {
    return favoriteRepository.findAll(
        search: param.search,
        limit: param.limit,
        page: param.page,
        lastID: param.lastID);
  }
}

class FindFavoritesUsecaseParam extends Equatable {
  final String? search;
  final int? limit;
  final int? page;
  final int? lastID;
  const FindFavoritesUsecaseParam(
      {this.limit, this.page, this.lastID, this.search});

  @override
  List<Object?> get props => [];
}
