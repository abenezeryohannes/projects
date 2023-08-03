import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/company/repositories/i.company.repository.dart';

import '../../../infrastructure/company/dto/company.dto.dart';

class EditCompanyUsecase
    implements UseCase<WrapperDto<CompanyEntity>, EditCompanyUsecaseParam> {
  final ICompanyRepository companyRepository;

  EditCompanyUsecase({required this.companyRepository});

  @override
  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? call(
      {required EditCompanyUsecaseParam param}) {
    return companyRepository.editCompany(companyDto: param.companyDto);
  }
}

class EditCompanyUsecaseParam extends Equatable {
  final CompanyDto companyDto;
  const EditCompanyUsecaseParam({required this.companyDto});

  @override
  List<Object?> get props => [companyDto];
}
