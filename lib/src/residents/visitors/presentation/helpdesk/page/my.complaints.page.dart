import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/controller/my.complaint.controller.dart';

import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/show.error.dart';
import '../../../domain/entities/complaint.entity.dart';
import '../widgets/complaint.card.dart';

@injectable
class MyComplaintsPage extends StatefulWidget {
  const MyComplaintsPage({super.key});

  @override
  State<MyComplaintsPage> createState() => _MyComplaintsPageState();
}

class _MyComplaintsPageState extends State<MyComplaintsPage> {
  late MyComplaintController controller;
  @override
  void initState() {
    controller = getIt<MyComplaintController>();
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
    return PagedListView<int, ComplaintEntity?>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
            noItemsFoundIndicatorBuilder: (_) => Padding(
                  padding:
                      const EdgeInsets.only(top: 200.0, left: 30, right: 30),
                  child: ShowError(
                      failure: NoDataFailure(message: "No complaints yet !!"),
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
                          top: 20,
                          bottom: index == 9 ? 30 : 0,
                          left: 10,
                          right: 10),
                      child: const ComplaintCard(),
                    )),
            itemBuilder: ((context, item, index) => Padding(
                  padding: EdgeInsets.only(
                      top: index == 0 ? 20 : 10,
                      bottom: index ==
                              (controller.pagingController.itemList?.length ??
                                      1) -
                                  1
                          ? 100
                          : 0,
                      left: 16,
                      right: 16),
                  child: ComplaintCard(
                      item: item,
                      mine: true,
                      showDate: index == 0 ||
                          (index > 0 &&
                              controller.pagingController.itemList![index - 1]!
                                      .createdAt()
                                      .difference(item!.createdAt())
                                      .inDays !=
                                  0)),
                ))));
  }
}
