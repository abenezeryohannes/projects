import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rnginfra/src/residents/visitors/presentation/visitors/controller/get.visitor.activities.controller.dart';

import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/domain/entities/guest.visitation.entity.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/show.error.dart';
import '../widgets/visitor.activity.card.dart';
import '../widgets/visitor.activity.date.picker.dart';

class VisitorsActivityPage extends StatefulWidget {
  VisitorsActivityPage({super.key});
  final _activityPageState = _VisitorsActivityPageState();

  @override
  State<VisitorsActivityPage> createState() => _activityPageState;

  void reload() {
    _activityPageState.reload();
  }
}

class _VisitorsActivityPageState extends State<VisitorsActivityPage> {
  late GetVisitorActivitiesController activityController;

  void reload() {
    if (!activityController.isClosed) {
      activityController.pagingController.refresh();
    }
  }

  @override
  void initState() {
    activityController = getIt<GetVisitorActivitiesController>();

    activityController.pagingController.addPageRequestListener((pageKey) {
      activityController.findAll(
          page: pageKey,
          limit: GetVisitorActivitiesController.pageSize,
          startTime: activityController.selectedDay.value,
          endTime: activityController.selectedDay.value
              ?.add(const Duration(days: 1)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) => VisitorActivityDatePicker(
                            date: activityController.selectedDay.value ??
                                DateTime.now(),
                            onDatePicked: (DateTime date) {
                              activityController.selectedDay.value = date;
                              activityController.pagingController.refresh();
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                Navigator.maybePop(context);
                              });
                            },
                          ));
                },
                icon: Icon(
                  Icons.calendar_month,
                  size: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ))
          ],
          centerTitle: false,
          elevation: 0.3,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Visitors',
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
        //body: //const GuardAddGuestActivity()
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  if (!activityController.isClosed) {
                    activityController.pagingController.refresh();
                  }
                },
                child: PagedListView<int, GuestVisitationEntity?>(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    pagingController: activityController.pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                        noItemsFoundIndicatorBuilder: (_) => Padding(
                              padding: const EdgeInsets.only(
                                  top: 200.0, left: 30, right: 30),
                              child: ShowError(
                                  failure: NoDataFailure(
                                      message: NoDataException().message),
                                  ErrorShowType: ErrorShowType.Vertical),
                            ),
                        firstPageErrorIndicatorBuilder: (context) => Padding(
                              padding: const EdgeInsets.only(
                                  top: 200.0, left: 30, right: 30),
                              child: ShowError(
                                  failure:
                                      activityController.pagingController.error,
                                  ErrorShowType: ErrorShowType.Vertical,
                                  onRetry: () => activityController
                                      .pagingController
                                      .refresh()),
                            ),
                        firstPageProgressIndicatorBuilder: (context) =>
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: 20,
                                itemBuilder: (ctx, index) => Padding(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: index == 9 ? 30 : 0,
                                          left: 10,
                                          right: 10),
                                      child: const VisitorActivityCard(),
                                    )),
                        itemBuilder: ((context, item, index) => Padding(
                              padding: EdgeInsets.only(
                                  top: index == 0 ? 0 : 10,
                                  bottom: index ==
                                          (activityController.pagingController
                                                      .itemList?.length ??
                                                  1) -
                                              1
                                      ? 100
                                      : 0,
                                  left: 16,
                                  right: 16),
                              child: VisitorActivityCard(
                                  visitation: item,
                                  showDate: index == 0 ||
                                      (index > 0 &&
                                          activityController.pagingController
                                                  .itemList![index - 1]!
                                                  .createdAt()
                                                  .difference(item!.createdAt())
                                                  .inDays !=
                                              0)),
                            )))),
              ),
            ),
          ],
        ));
  }
}
