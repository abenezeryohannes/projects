import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import '../../../../../core/data/pagination.dto.dart';
import '../../repositories/i.complaint.repository.dart';

@singleton
class GetComplaintsUseCase
    extends UseCase<Pagination<ComplaintEntity>, GetComplaintsParam> {
  final IComplaintRepository repo;
  GetComplaintsUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<ComplaintEntity>>?>? call(
      GetComplaintsParam param) {
    return repo.getComplaints(
        page: param.page,
        search: param.search,
        limit: param.limit,
        categoryID: param.categoryID);
  }
}

class GetComplaintsParam extends Equatable {
  final String? search;
  final int? page;
  final int? limit;
  final String? categoryID;

  const GetComplaintsParam(
      {this.search, this.page, this.limit, this.categoryID});

  @override
  List<Object?> get props => [search, page, limit];
}
