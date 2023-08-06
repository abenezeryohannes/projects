import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/usecases/usecase.dart';
import 'package:linko/src/domain/chat/repositories/i.chat.repository.dart';

@lazySingleton
class ClearHistoryUsecase
    implements UseCase<WrapperDto?, ClearHistoryUsecaseNoParam> {
  final IChatRepository chatRepository;

  ClearHistoryUsecase({required this.chatRepository});

  @override
  Future<Either<Failure, WrapperDto>?>? call(
      {required ClearHistoryUsecaseNoParam param}) {
    return chatRepository.clearAll();
  }
}

class ClearHistoryUsecaseNoParam extends Equatable {
  const ClearHistoryUsecaseNoParam();

  @override
  List<Object?> get props => [];
}
