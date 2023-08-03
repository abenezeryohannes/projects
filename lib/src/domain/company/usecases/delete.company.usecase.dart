import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/company/repositories/i.company.repository.dart';

class DeleteCompanyUsecase
    implements UseCase<WrapperDto, DeleteCompanyUsecaseParam> {
  final ICompanyRepository companyRepository;

  DeleteCompanyUsecase({required this.companyRepository});

  @override
  Future<Either<Failure, WrapperDto>?>? call(
      {required DeleteCompanyUsecaseParam param}) {
    return companyRepository.deleteCompany(company: param.company);
  }
}

class DeleteCompanyUsecaseParam extends Equatable {
  final CompanyEntity company;
  const DeleteCompanyUsecaseParam({required this.company});

  @override
  List<Object?> get props => [company];
}
