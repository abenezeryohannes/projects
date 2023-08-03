import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:linko/src/domain/chat/repositories/i.chat.repository.dart';

@lazySingleton
class FindAllChatUsecase
    implements UseCase<WrapperDto<ChatEntity>?, FindAllChatUsecaseParam> {
  final IChatRepository chatRepository;

  FindAllChatUsecase({required this.chatRepository});

  @override
  Future<Either<Failure, WrapperDto<ChatEntity>>?>? call(
      {required FindAllChatUsecaseParam param}) {
    return chatRepository.findAll(
        id: param.id, page: param.page, limit: param.limit);
  }
}

class FindAllChatUsecaseParam extends Equatable {
  final int? page;
  final int? limit;
  final int? id;
  const FindAllChatUsecaseParam({this.page = 1, this.limit = 25, this.id});

  @override
  List<Object?> get props => [page, limit, id];
}
