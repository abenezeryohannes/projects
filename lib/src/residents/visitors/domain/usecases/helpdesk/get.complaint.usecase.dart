import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import '../../entities/complaint.entity.dart';
import '../../repositories/i.complaint.repository.dart';

@singleton
class GetComplaintUseCase extends UseCase<ComplaintEntity, GetComplaintParam> {
  final IComplaintRepository repo;
  GetComplaintUseCase({required this.repo});

  @override
  Future<Either<Failure, ComplaintEntity>?>? call(GetComplaintParam param) {
    return repo.getComplaint(
      id: param.id,
    );
  }
}

class GetComplaintParam extends Equatable {
  final String id;
  const GetComplaintParam({required this.id});

  @override
  List<Object?> get props => [id];
}
