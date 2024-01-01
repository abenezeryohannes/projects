import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/create.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/repositories/i.complaint.repository.dart';

@singleton
class AddComplaintUseCase extends UseCase<ComplaintEntity, AddComplaintParam> {
  final IComplaintRepository repo;
  AddComplaintUseCase({required this.repo});

  @override
  Future<Either<Failure, ComplaintEntity>?>? call(AddComplaintParam param) {
    return repo.addComplaint(complaint: param.complaint);
  }
}

class AddComplaintParam extends Equatable {
  final CreateComplaintEntity complaint;

  const AddComplaintParam({
    required this.complaint,
  });

  @override
  List<Object?> get props => [complaint];
}
