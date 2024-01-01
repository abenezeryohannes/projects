import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/comment.entity.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/controller/comment.controller.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/widgets/comment.card.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/widgets/comment.page.bottom.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/show.error.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.id, this.page = true});
  final String id;
  final bool page;
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late CommentController controller;
  int count = 0;
  @override
  void initState() {
    controller = getIt<CommentController>();

    controller.pagingController.addPageRequestListener((pageKey) {
      controller.find(page: pageKey, id: widget.id);
    });

    super.initState();
  }

  Widget page() {
    if (widget.page) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _appBar(),
        body: SafeArea(
          child: Obx(() => PageBody()),
        ),
      );
    } else {
      return PageBody();
    }
  }

  Widget PageBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (controller.loading.value) const LoadingBar(),
        Expanded(child: _body()),
        Container(
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 80),
            child: CommentPageBottom(
              onSend: (text) {
                if (text.isNotEmpty) {
                  return controller.addComment(
                      onSuccess: (comment) {
                        controller.pagingController.refresh();
                      },
                      id: widget.id,
                      comment: text);
                }
                return Future.value(false);
              },
              loading: controller.loading.value,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return page();
  }

  Widget _body() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.pagingController.refresh();
      },
      child: PagedListView<int, CommentEntity?>(
          shrinkWrap: true,
          reverse: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
              noItemsFoundIndicatorBuilder: (_) => !widget.page
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 100.0, left: 30, right: 30),
                      child: ShowError(
                          height: 200,
                          failure:
                              NoDataFailure(message: "No comments here yet !!"),
                          ErrorShowType: ErrorShowType.Vertical),
                    ),
              firstPageErrorIndicatorBuilder: (context) => Padding(
                    padding:
                        const EdgeInsets.only(top: 200.0, left: 30, right: 30),
                    child: ShowError(
                      height: 200,
                      failure: controller.pagingController.error,
                      ErrorShowType: ErrorShowType
                          .Vertical, /*onRetry: () => controller.pagingController.refresh()*/
                    ),
                  ),
              firstPageProgressIndicatorBuilder: (context) => ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (ctx, index) => Padding(
                        padding: EdgeInsets.only(
                            top: index == 2 ? 20 : 0,
                            bottom: index == 0 ? 20 : 0,
                            left: 16,
                            right: 16),
                        child: const CommentCard(),
                      )),
              itemBuilder: ((context, item, index) => Padding(
                    padding: EdgeInsets.only(
                        top: index ==
                                (controller.pagingController.itemList?.length ??
                                        0) -
                                    1
                            ? 20
                            : 0,
                        bottom: index == 0 ? 20 : 0,
                        left: 16,
                        right: 16),
                    child: CommentCard(
                      comment: item,
                    ),
                  )))),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.5,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.chevron_left,
          size: 42,
          color: Theme.of(context).disabledColor,
        ),
      ),
      title: Text(
        'Comments',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              controller.pagingController.refresh();
            },
            icon: Icon(
              Icons.refresh_outlined,
              color: Theme.of(context).disabledColor,
            ))
      ],
    );
  }
}
