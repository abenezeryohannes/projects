import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:linko/src/domain/chat/usecases/findAll.chat.usecase.dart';
import 'package:linko/src/domain/user/usecases/get.user.usecase.dart';

import '../../appcore/errors/exceptions.dart';
import '../../appcore/errors/failure.dart';
import '../../domain/user/entities/user.entity.dart';

@injectable
class ChatController extends GetxController {
  final GetUserUsecase _findUserUsecase;
  final FindAllChatUsecase _findAllChatUsecase;

  ChatController(this._findUserUsecase, this._findAllChatUsecase);
  late ScrollController scrollController;

  RxString text = ''.obs;
  RxInt page = 0.obs;

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  RxBool loading = RxBool(false);
  Rx<Failure?> failure = Rx<Failure?>(null);
  RxList<ChatEntity> chatList = RxList.empty();
  Rx<WrapperDto<ChatEntity>?> chatWrapper = Rx<WrapperDto<ChatEntity>?>(null);

  Future findAll({int? id, int? limit, int? page}) async {
    if (id == null) {
      failure.value = null;
      loading.value = true;
      failure.refresh();
      loading.refresh();
    }

    final result = await _findAllChatUsecase(
        param: FindAllChatUsecaseParam(id: id, page: page, limit: limit));

    if (result == null) {
      loading.value = false;
      failure.value = UnExpectedFailure(message: UnExpectedException().message);
      failure.refresh();
      loading.refresh();
    } else {
      result.fold((l) {
        // loading.value = false;
        // failure.value = l;
        // failure.refresh();
        // loading.refresh();
      }, (r) {
        chatWrapper.value = r;
        chatWrapper.refresh();
        if (r.datas != null) {
          if (id == null || id < 1) {
            chatList.insertAll(0, r.datas!);
          } else {
            chatList.addAll(r.datas!);
          }
          chatList.refresh();
          if (scrollController.hasClients && (id == null || id < 1)) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
            );
          }
        }
        // loading.value = false;
        // loading.refresh();
      });
    }
  }

  Future findUser({bool local = true}) async {
    final result =
        await _findUserUsecase(param: GetUserUsecaseNoParam(local: local));

    if (result != null) {
      result.fold((l) {}, (r) {
        if (r.data != null) {
          user.value = r.data;
          user.refresh();
        }
      });
    }
  }

  bool allLoaded() {
    return ((chatWrapper.value?.count ?? 0) < (chatWrapper.value?.limit ?? 0));
  }
}
