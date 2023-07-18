import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/guards/patroll/data/dtos/add.patroll.dto.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';

import '../../../core/data/pagination.dto.dart';

abstract class IPatrollRepository {
  Future<Either<Failure, bool>?>? addPatroll({required AddPatrollDto patroll});
  Future<Either<Failure, bool>?>? deletePatroll(
      {required PatrollEntity patroll});
  Future<Either<Failure, PatrollEntity>?>? editPatroll(
      {required PatrollEntity patroll, required int id});
  Future<Either<Failure, Pagination<PatrollEntity>>?>? listPatroll(
      {int? page, int? limit, DateTime? startTime, DateTime? endTime});
}
