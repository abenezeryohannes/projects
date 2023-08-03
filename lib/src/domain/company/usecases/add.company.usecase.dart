import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/company/repositories/i.company.repository.dart';
import 'package:linko/src/infrastructure/company/dto/company.dto.dart';

@lazySingleton
class AddCompanyUsecase
    implements UseCase<WrapperDto<CompanyEntity>, AddCompanyUsecaseParam> {
  final ICompanyRepository companyRepository;

  AddCompanyUsecase({required this.companyRepository});

  @override
  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? call(
      {required AddCompanyUsecaseParam param}) {
    return companyRepository.addCompany(companyDto: param.companyDto);
  }
}

class AddCompanyUsecaseParam extends Equatable {
  final CompanyDto companyDto;
  const AddCompanyUsecaseParam({required this.companyDto});

  @override
  List<Object?> get props => [companyDto];
}
