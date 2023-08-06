import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:linko/injectable/getit.dart';
import 'package:linko/src/appcore/errors/exceptions.dart';
import 'package:linko/src/appcore/widgets/bottom.sheet.button.dart';
import 'package:linko/src/application/chat/history.controller.dart';
import 'package:linko/src/presentation/chat/widgets/history.card.dart';

import '../../appcore/errors/failure.dart';
import '../../appcore/widgets/show.error.dart';
import '../../domain/chat/entities/chat.entity.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryController controller;

  @override
  void initState() {
    controller = getIt<HistoryController>();
    controller.findUser();

    controller.pagingController.addPageRequestListener((pageKey) {
      controller.findAll(page: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).maybePop();
      },
      backgroundColor: Theme.of(context).disabledColor,
      startingOpacity: 0.2,
      direction: DismissiblePageDismissDirection.down,
      isFullScreen: true,
      child: Scaffold(appBar: _appBar(), body: body()),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: Icon(
        Icons.chevron_left,
        size: 42,
        color: Theme.of(context).disabledColor,
      ),
      title: Text(
        'History',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.defaultDialog(
                      onConfirm: () {
                        Get.back<bool>(result: true);
                      },
                      onCancel: () {
                        return;
                      },
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      title: 'Are you sure?',
                      middleText:
                          'This will delete all you chat histories from the app!',
                      textConfirm: 'Yes, am sure',
                      textCancel: 'Nevermind')
                  .then((value) {
                if (value != null) {
                  controller.clearAll();
                }
              });
            },
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(100))),
              child: Image.asset(
                'assets/icon/delete.png',
                width: 20,
                height: 20,
                color: Theme.of(context).disabledColor,
              ),
            ))
      ],
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.pagingController.refresh();
              },
              child: PagedListView<int, ChatEntity?>(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<ChatEntity?>(
                    noItemsFoundIndicatorBuilder: (context) => Padding(
                        padding: const EdgeInsets.only(top: 200.0),
                        child: ShowError(
                            failure: NoDataFailure(
                                message: NoDataException().message))),
                    firstPageErrorIndicatorBuilder: (_) => Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: ShowError(
                              failure:
                                  controller.pagingController.error as Failure),
                        ),
                    firstPageProgressIndicatorBuilder: (_) => ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 0.0),
                          children: const [
                            HistoryCard(),
                            HistoryCard(),
                            HistoryCard(),
                            HistoryCard(),
                            HistoryCard(),
                            HistoryCard(),
                          ],
                        ),
                    itemBuilder: (context, item, index) => HistoryCard(
                        chat: item,
                        responses: getResponses(controller.chatList, item))),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<ChatEntity>? getResponses(
      List<ChatEntity>? histories, ChatEntity? chat) {
    if (histories == null || chat == null) return [];
    final index = histories.indexOf(chat);
    if (index <= 1) return [];

    List<ChatEntity> response = [];
    for (int i = index - 1; i >= 0; i--) {
      if (histories[i].id > chat.id && histories[i].sender == null) {
        response.add(histories[i]);
      } else {
        return response;
      }
    }
    return response;
  }
}
