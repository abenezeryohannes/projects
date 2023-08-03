import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/company/repositories/i.company.repository.dart';

class FindCompanyUsecase
    implements UseCase<WrapperDto<CompanyEntity>?, FindCompanyUsecaseParam> {
  final ICompanyRepository companyRepository;

  FindCompanyUsecase({required this.companyRepository});

  @override
  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? call(
      {required FindCompanyUsecaseParam param}) {
    return companyRepository.findCompanies(search: param.search);
  }
}

class FindCompanyUsecaseParam extends Equatable {
  final String? search;
  const FindCompanyUsecaseParam({this.search});

  @override
  List<Object?> get props => [];
}
