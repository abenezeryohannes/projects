import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/chat/repositories/i.chat.repository.dart';

@lazySingleton
class ClearChatUsecase
    implements UseCase<WrapperDto?, ClearChatUsecaseNoParam> {
  final IChatRepository chatRepository;

  ClearChatUsecase({required this.chatRepository});

  @override
  Future<Either<Failure, WrapperDto>?>? call(
      {required ClearChatUsecaseNoParam param}) {
    return chatRepository.clear(chatId: param.chatId);
  }
}

class ClearChatUsecaseNoParam extends Equatable {
  final int chatId;
  const ClearChatUsecaseNoParam({required this.chatId});

  @override
  List<Object?> get props => [];
}
