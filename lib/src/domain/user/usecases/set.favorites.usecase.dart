import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';

import '../repositories/i.favorite.repository.dart';

@lazySingleton
class SetFavoriteUsecase
    implements UseCase<WrapperDto, SetFavoriteUsecaseParam> {
  final IFavoriteRepository favoriteRepository;

  SetFavoriteUsecase({required this.favoriteRepository});

  @override
  Future<Either<Failure, WrapperDto>?>? call(
      {required SetFavoriteUsecaseParam param}) {
    return favoriteRepository.setFavorite(company: param.company);
  }
}

class SetFavoriteUsecaseParam extends Equatable {
  final CompanyEntity company;
  const SetFavoriteUsecaseParam({required this.company});

  @override
  List<Object?> get props => [company];
}
