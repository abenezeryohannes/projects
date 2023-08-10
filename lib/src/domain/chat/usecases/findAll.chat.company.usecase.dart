import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/chat/repositories/i.chat.repository.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';

@lazySingleton
class FindAllChatCompanyUsecase
    implements
        UseCase<WrapperDto<CompanyEntity>?, FindAllChatCompanyUsecaseParam> {
  final IChatRepository chatRepository;

  FindAllChatCompanyUsecase({required this.chatRepository});

  @override
  Future<Either<Failure, WrapperDto<CompanyEntity>>?>? call(
      {required FindAllChatCompanyUsecaseParam param}) {
    return chatRepository.findAllCompaniesWithId(
        ids: param.ids, id: param.id, page: param.page, limit: param.limit);
  }
}

class FindAllChatCompanyUsecaseParam extends Equatable {
  final int? page;
  final int? limit;
  final int? id;
  final List<int> ids;
  const FindAllChatCompanyUsecaseParam({
    this.page = 1,
    this.limit = 25,
    this.id,
    required this.ids,
  });

  @override
  List<Object?> get props => [page, limit, id, ids];
}
