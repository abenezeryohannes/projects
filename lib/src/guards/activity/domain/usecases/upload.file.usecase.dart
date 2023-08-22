import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/usecases/usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/file.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/repositories/i.activities.repository.dart';

@singleton
class UploadFileUseCase extends UseCase<FileEntity, UploadFileParam> {
  final IActivityRepository repo;
  UploadFileUseCase({required this.repo});

  @override
  Future<Either<Failure, FileEntity>?>? call(UploadFileParam param) {
    return repo.uploadFile(file: param.file);
  }
}

class UploadFileParam extends Equatable {
  final String file;
  const UploadFileParam({required this.file});
  @override
  List<Object?> get props => [file];
}
