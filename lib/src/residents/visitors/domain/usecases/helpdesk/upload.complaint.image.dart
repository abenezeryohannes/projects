import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/file.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/repositories/i.complaint.repository.dart';

@singleton
class UploadComplaintImageUseCase
    extends UseCase<FileEntity, UploadComplaintImageParam> {
  final IComplaintRepository repo;
  UploadComplaintImageUseCase({required this.repo});

  @override
  Future<Either<Failure, FileEntity>?>? call(UploadComplaintImageParam param) {
    return repo.uploadFile(file: param.file);
  }
}

class UploadComplaintImageParam extends Equatable {
  final String file;
  const UploadComplaintImageParam({required this.file});
  @override
  List<Object?> get props => [file];
}
