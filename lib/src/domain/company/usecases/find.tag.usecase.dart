import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';

import '../entities/tag.entity.dart';
import '../repositories/i.tag.repository.dart';

@lazySingleton
class FindTagUsecase
    implements UseCase<WrapperDto<TagEntity>?, FindTagUsecaseParam> {
  final ITagRepository tagRepository;

  FindTagUsecase({required this.tagRepository});

  @override
  Future<Either<Failure, WrapperDto<TagEntity>>?>? call(
      {required FindTagUsecaseParam param}) {
    return tagRepository.findAll(search: param.search);
  }
}

class FindTagUsecaseParam extends Equatable {
  final String? search;
  const FindTagUsecaseParam({this.search});

  @override
  List<Object?> get props => [search];
}
