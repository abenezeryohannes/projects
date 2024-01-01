import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import '../../../../../core/data/pagination.dto.dart';
import '../../repositories/i.complaint.repository.dart';

@singleton
class GetMyComplaintsUseCase
    extends UseCase<Pagination<ComplaintEntity>, GetMyComplaintsParam> {
  final IComplaintRepository repo;
  GetMyComplaintsUseCase({required this.repo});

  @override
  Future<Either<Failure, Pagination<ComplaintEntity>>?>? call(
      GetMyComplaintsParam param) {
    return repo.getMyComplaints(
        page: param.page,
        search: param.search,
        limit: param.limit,
        offline: param.offline);
  }
}

class GetMyComplaintsParam extends Equatable {
  final String? search;
  final int? page;
  final int? limit;
  final bool offline;

  const GetMyComplaintsParam(
      {this.search, this.page, this.limit, this.offline = false});

  @override
  List<Object?> get props => [search, page, limit];
}
