import 'package:dartz/dartz.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';

import '../../../appcore/errors/failure.dart';

abstract class ITagRepository {
  // Future<Either<Failure, WrapperDto<TagEntity>>?>? editTag(
  //     {required TagEntity tag});

  // Future<Either<Failure, WrapperDto>?>? deleteTag({required TagEntity tag});

  // Future<Either<Failure, WrapperDto<TagEntity>>?>? addTag(
  //     {required TagEntity tag});

  Future<Either<Failure, WrapperDto<TagEntity>>?>? findAll({String? search});
}
