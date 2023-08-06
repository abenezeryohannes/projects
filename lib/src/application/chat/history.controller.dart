import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/widgets/app.snackbar.dart';
import 'package:linko/src/appcore/widgets/show.error.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:linko/src/domain/chat/usecases/clear.history.usecase.dart';
import 'package:linko/src/domain/chat/usecases/findAll.chat.usecase.dart';
import 'package:linko/src/domain/user/usecases/get.user.usecase.dart';

import '../../appcore/errors/exceptions.dart';
import '../../appcore/errors/failure.dart';
import '../../domain/user/entities/user.entity.dart';

@injectable
class HistoryController extends GetxController {
  final GetUserUsecase _findUserUsecase;
  final FindAllChatUsecase _findAllChatUsecase;
  final ClearHistoryUsecase _clearHistoryUsecase;

  HistoryController(this._findUserUsecase, this._findAllChatUsecase,
      this._clearHistoryUsecase);
  late ScrollController scrollController;

  RxString text = ''.obs;
  RxInt page = 0.obs;

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  RxBool loading = RxBool(false);
  Rx<Failure?> failure = Rx<Failure?>(null);
  RxList<ChatEntity> chatList = RxList.empty();
  Rx<WrapperDto<ChatEntity>?> chatWrapper = Rx<WrapperDto<ChatEntity>?>(null);

  static const _pageSize = 25;

  final PagingController<int, ChatEntity?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future clearAll() async {
    final result =
        await _clearHistoryUsecase(param: const ClearHistoryUsecaseNoParam());

    if (result == null) {
      AppSnackBar.failure(
          failure: Failure(message: UnExpectedException().message));
    } else {
      result.fold((l) {
        AppSnackBar.failure(failure: l);
      }, (r) {
        pagingController.refresh();
      });
    }
  }

  Future findAll({int? id, int? limit, int page = 1}) async {
    final result = await _findAllChatUsecase(
        param: FindAllChatUsecaseParam(id: id, page: page, limit: limit));

    if (result == null) {
      pagingController.error = Failure(message: UnExpectedException().message);
    } else {
      result.fold((l) {
        pagingController.error = l;
      }, (r) {
        chatWrapper.value = r;
        final isLastPage = (r.datas?.length ?? 0) < (_pageSize);
        if (isLastPage) {
          if (r.datas != null) {
            pagingController.appendLastPage(r.datas!
                .where((element) => element.sender != null)
                .toList()
                .cast<ChatEntity?>());
          }
        } else {
          if (r.datas != null) {
            chatList.addAll(r.datas!.where((element) => true));
            pagingController.appendPage(
                r.datas!
                    .where((element) => element.sender != null)
                    .toList()
                    .cast<ChatEntity?>(),
                page + 1);
          }
          if (page == 1 && (r.datas == null || r.datas!.isEmpty)) {
            pagingController.notifyStatusListeners(PagingStatus.completed);
          }
        }
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
