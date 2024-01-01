import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/controller/my.reactions.controller.dart';

import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/show.error.dart';
import '../widgets/complaint.card.dart';
import '../widgets/reaction.card.dart';

class MyReactionsPage extends StatefulWidget {
  const MyReactionsPage({super.key});

  @override
  State<MyReactionsPage> createState() => _MyReactionsPageState();
}

class _MyReactionsPageState extends State<MyReactionsPage> {
  late MyReactionController controller;
  @override
  void initState() {
    controller = getIt<MyReactionController>();
    controller.pagingController.addPageRequestListener((pageKey) {
      controller.find(page: pageKey);
    });
    super.initState();
  }

  void reload() {
    controller.pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return PagedListView<int, VoteComplaintEntity?>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
            noItemsFoundIndicatorBuilder: (_) => Padding(
                  padding:
                      const EdgeInsets.only(top: 200.0, left: 30, right: 30),
                  child: ShowError(
                      failure: NoDataFailure(message: "No reactions yet !!"),
                      ErrorShowType: ErrorShowType.Vertical),
                ),
            firstPageErrorIndicatorBuilder: (context) => Padding(
                  padding:
                      const EdgeInsets.only(top: 100.0, left: 30, right: 30),
                  child: ShowError(
                      failure: controller.pagingController.error,
                      ErrorShowType: ErrorShowType.Vertical,
                      onRetry: () {
                        setState(() {
                          controller.pagingController.refresh();
                        });
                      }),
                ),
            firstPageProgressIndicatorBuilder: (context) => ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (ctx, index) => Container(
                      padding: EdgeInsets.only(
                          bottom: index == 9 ? 30 : 0, left: 10, right: 10),
                      child: const ReactionCard(),
                    )),
            itemBuilder: ((context, item, index) => Padding(
                  padding: EdgeInsets.only(
                      top: index == 0 ? 0 : 10,
                      bottom: index ==
                              (controller.pagingController.itemList?.length ??
                                      1) -
                                  1
                          ? 100
                          : 0,
                      left: 16,
                      right: 16),
                  child: ReactionCard(
                      vote: item,
                      showDate: index == 0 ||
                          (index > 0 &&
                              controller.pagingController.itemList![index - 1]!
                                      .timestamp!
                                      .difference(item!.timestamp!)
                                      .inDays !=
                                  0)),
                ))));
  }
}
