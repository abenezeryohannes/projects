import 'package:dartz/dartz.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';

import '../../../appcore/errors/failure.dart';
import '../../../infrastructure/company/dto/company.dto.dart';

abstract class ICompanyRepository {
  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? editCompany(
      {required CompanyDto companyDto});

  Future<Either<Failure, WrapperDto>?>? deleteCompany(
      {required CompanyEntity company});

  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? addCompany(
      {required CompanyDto companyDto});

  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? findCompanies(
      {String? search});
}
