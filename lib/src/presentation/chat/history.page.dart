import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:linko/injectable/getit.dart';
import 'package:linko/src/appcore/errors/exceptions.dart';
import 'package:linko/src/application/chat/history.controller.dart';
import 'package:linko/src/presentation/chat/widgets/chat.app.bar.dart';
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
        Get.back(result: 'refresh');
      },
      backgroundColor: Theme.of(context).disabledColor,
      startingOpacity: 0.2,
      direction: DismissiblePageDismissDirection.down,
      isFullScreen: true,
      child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(appBar: _appBar(), body: body())),
    );
  }

  AppBar _appBar() {
    return AppBar(
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
        'history'.tr,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              openDialog(
                  title: "are_you_sure".tr,
                  body: "this_will_delete_all_chats".tr,
                  yes: 'yes_am_sure'.tr,
                  no: 'nevermind'.tr,
                  onYes: () {
                    ChatAppBar.refresh = true;
                    Navigator.maybePop(context);
                    controller.clearAll();
                  },
                  onNo: () {
                    Navigator.maybePop(context);
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
                    itemBuilder: (context, item, index) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HistoryCard(
                                chat: item,
                                responses:
                                    getResponses(controller.chatList, item)),
                            if (index <
                                (controller.pagingController.itemList?.length ??
                                        0) -
                                    1)
                              Container(
                                color: Theme.of(context).hoverColor,
                                height: 1,
                                width: MediaQuery.of(context).size.width *
                                    (10 / 12),
                              ),
                          ],
                        )),
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

  openDialog(
      {required String title,
      required String body,
      required String yes,
      required String no,
      required Function onYes,
      required Function onNo}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(primarySwatch: Colors.grey),
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
            content: Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    onYes();
                  },
                  child: Text(
                    yes,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  )),
              TextButton(
                  onPressed: () {
                    onNo();
                  },
                  child: Text(
                    no,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  )),
            ],
          ),
        );
      },
    );
  }
}
