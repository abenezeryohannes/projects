import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/add.comments.usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/get.comments.usecase.dart';

import '../../../../../core/data/pagination.dto.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/app.snackbar.dart';

@injectable
class CommentController extends GetxController {
  final GetCommentsUseCase _getCommentsUseCase;
  final AddCommentUseCase _addCommentUseCase;

  CommentController(this._getCommentsUseCase, this._addCommentUseCase);

  final PagingController<int, CommentEntity?> pagingController =
      PagingController(firstPageKey: 1);

  RxList<CommentEntity> comments = RxList<CommentEntity>([]);

  Rx<Pagination<CommentEntity?>?> commentsPagination =
      Rx<Pagination<CommentEntity?>?>(null);

  RxBool loading = false.obs;

  Future find(
      {required String id,
      String? search,
      int limit = 25,
      int page = 1}) async {
    final result = await _getCommentsUseCase(
        GetCommentsParam(id: id, search: search, page: page, limit: limit));

    if (result == null) {
      pagingController.error = Failure(message: UnExpectedException().message);
    } else {
      result.fold((l) {
        pagingController.error = l;
      }, (r) {
        commentsPagination.value = r;
        final isLastPage = (r.results?.length ?? 0) < (limit);
        if (isLastPage) {
          if (r.results != null) {
            comments.addAll(r.results!.where((element) => true));
            pagingController
                .appendLastPage(r.results!.toList().cast<CommentEntity?>());
          }
        } else {
          if (r.results != null) {
            comments.addAll(r.results!.where((element) => true));
            pagingController.appendPage(
                r.results!.cast<CommentEntity?>(), page + 1);
          }
          if (page == 1 && (r.results == null || r.results!.isEmpty)) {
            pagingController.notifyStatusListeners(PagingStatus.completed);
          }
        }
      });
    }
  }

  Future<bool> addComment(
      {required Function(CommentEntity) onSuccess,
      required String id,
      required String comment}) async {
    loading.value = true;
    loading.refresh();
    final result = await _addCommentUseCase(AddCommentParam(
        comment: AddCommentEntity(
            comment_body: comment, entity_id: int.tryParse(id))));

    if (result == null) {
      AppSnackBar.warning(
          title: 'Error loading categories',
          message: UnExpectedException().message);
      return false;
    } else {
      result.fold((l) {
        AppSnackBar.warning(
            title: 'Error loading categories', message: l.message);
      }, (r) {
        onSuccess(r);
      });
    }
    loading.value = false;
    loading.refresh();
    if (result.isRight()) return true;
    return false;
  }
}
