import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/category.entity.dart';
import '../../../../../core/data/pagination.dto.dart';
import '../../repositories/i.complaint.repository.dart';

@singleton
class GetComplaintCategoriesUseCase
    extends UseCase<Pagination<CategoryEntity>, GetComplaintCategoriesParam> {
  final IComplaintRepository repo;
  GetComplaintCategoriesUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<CategoryEntity>>?>? call(
      GetComplaintCategoriesParam param) {
    return repo.getCategories(
        page: param.page, search: param.search, limit: param.limit);
  }
}

class GetComplaintCategoriesParam extends Equatable {
  final String? search;
  final int? page;
  final int? limit;

  const GetComplaintCategoriesParam({this.search, this.page, this.limit});

  @override
  List<Object?> get props => [search, page, limit];
}
