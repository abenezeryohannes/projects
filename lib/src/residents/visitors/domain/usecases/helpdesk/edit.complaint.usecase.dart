import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/create.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/repositories/i.complaint.repository.dart';

@singleton
class EditComplaintUseCase
    extends UseCase<ComplaintEntity, EditComplaintParam> {
  final IComplaintRepository repo;
  EditComplaintUseCase({required this.repo});

  @override
  Future<Either<Failure, ComplaintEntity>?>? call(EditComplaintParam param) {
    return repo.updateComplaint(id: param.id, complaint: param.complaint);
  }
}

class EditComplaintParam extends Equatable {
  final String id;
  final CreateComplaintEntity complaint;

  const EditComplaintParam({required this.id, required this.complaint});

  @override
  List<Object?> get props => [id, complaint];
}
