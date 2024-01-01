import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/widgets/text.input.form.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/controller/help.desk.controller.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/widgets/complaint.card.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/drop.down.rng.dart';
import '../../../../../core/widgets/show.error.dart';
import '../../../domain/entities/category.entity.dart';

class HelpDeskPage extends StatefulWidget {
  HelpDeskPage({super.key});

  final result = _HelpDeskPageState();
  @override
  State<HelpDeskPage> createState() => result;

  void refresh() {
    result.reload();
  }
}

class _HelpDeskPageState extends State<HelpDeskPage> {
  late HelpDeskController controller;
  @override
  void initState() {
    controller = getIt<HelpDeskController>();
    controller.findCategories();
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
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.grey.shade100,
                floating: true,
                iconTheme: const IconThemeData(size: 0),
                leadingWidth: 0,
                leading: null,
                collapsedHeight: 70,
                expandedHeight: 130,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  title: _appBarBottom(),
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1,
                  background: _appBar(),
                ),
              ),
            ];
          },
          body: _body(),
        ));
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
                      failure: NoDataFailure(message: "No complains yet !!"),
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
                      child: const ComplaintCard(),
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
                  child: ComplaintCard(
                      item: item,
                      showDate: index == 0 ||
                          (index > 0 &&
                              controller.pagingController.itemList![index - 1]!
                                      .createdAt()
                                      .difference(item!.createdAt())
                                      .inDays !=
                                  0)),
                ))));
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          'Raised Compliants',
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }

  DateTime lastSearch = DateTime.now();
  Widget _appBarBottom() {
    return Container(
      color: Colors.grey.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Flexible(
              flex: 3,
              child: TextInputForm(
                  focusedBorderColor: Theme.of(context).hintColor,
                  placeholder: 'Search...',
                  onChanged: (val) {
                    if (controller.search.value != val &&
                        lastSearch.difference(DateTime.now()).inMilliseconds <
                            1000) {
                      controller.search.value = val;
                      Future.delayed(const Duration(milliseconds: 300),
                          () => controller.pagingController.refresh());
                    }
                    lastSearch = DateTime.now();
                  })),
          const SizedBox(
            width: 10,
          ),
          Obx(() => Flexible(
                flex: 2,
                child: DropDownRNG<CategoryEntity>(
                    title: 'Category',
                    items: controller.categories.value,
                    onSelected: (item) {
                      controller.selectedCategory = item as CategoryEntity;
                      Future.delayed(const Duration(milliseconds: 300),
                          () => controller.pagingController.refresh());
                    },
                    getOptionText: (dynamic item) {
                      return item?.name;
                    }),
              )),
          // const SizedBox(
          //   width: 10,
          // ),
          // Flexible(
          //   flex: 1,
          //   child: DropDownRNG<CategoryEntity>(
          //       title: 'status',
          //       items: categories,
          //       onSelected: (item) {},
          //       getOptionText: (dynamic item) {
          //         return item?.name;
          //       }),
          // ),
        ],
      ),
    );
  }
}
