import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.attendance.entity.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/controllers/add.staff.attendance.controller.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/pages/scan.staff.attendance.page.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/widgets/staff.attendance.card.dart';

import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/app.snackbar.dart';
import '../../../../../core/widgets/show.error.dart';
import '../bloc/staff_activity_bloc.dart';
import '../widgets/staff.activity.date.picker.dart';

class GuardStaffAttendancePage extends StatefulWidget {
  GuardStaffAttendancePage({super.key});
  final _staffAttendancePageState = _GuardStaffAttendancePageState();
  @override
  State<GuardStaffAttendancePage> createState() => _staffAttendancePageState;

  void reload() {
    _staffAttendancePageState.reload();
  }
}

class _GuardStaffAttendancePageState extends State<GuardStaffAttendancePage> {
  StaffActivityBloc activityBloc = getIt<StaffActivityBloc>();
  late DateTime? startTime;
  late DateTime? endTime;
  //
  void reload() {
    if (!activityBloc.isClosed) {
      activityBloc.pagingController.refresh();
    }
  }

  @override
  void initState() {
    activityBloc = getIt<StaffActivityBloc>();
    activityBloc.pagingController.addPageRequestListener((pageKey) {
      activityBloc.add(OnLoadStaffAttendanceEvent(
          startTime: activityBloc.selectedDay,
          endTime: activityBloc.selectedDay?.add(const Duration(days: 1)),
          page: pageKey,
          limit: activityBloc.pageLimit));
    });
    super.initState();
  }

  void _postScan(String qr) async {
    try {
      await getIt<AddStaffAttendanceController>()
          .addStaffSnack(targetId: qr, time: DateTime.now(), page: widget);
    } catch (e) {
      AppSnackBar.failure(failure: Failure(message: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ScanStaffAttendancePage()))
                    .then((value) async {
                  if (value != null) {
                    _postScan(value);
                  }
                });
              },
              icon: Icon(
                Icons.qr_code,
                size: 24,
                color: Theme.of(context).colorScheme.secondary,
              )),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => StaffActivityDatePicker(
                          date: activityBloc.selectedDay ?? DateTime.now(),
                          onDatePicked: (DateTime date) {
                            activityBloc.selectedDay = date;
                            activityBloc.pagingController.refresh();
                            // activityBloc.add(OnLoadStaffAttendanceEvent(
                            //     page: 0,
                            //     limit: activityBloc.pageLimit,
                            //     startTime: activityBloc.selectedDay,
                            //     endTime: activityBloc.selectedDay!
                            //         .add(const Duration(days: 1))));
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
              )),
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
              'Staff Activities',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
      body: BlocProvider(
        create: (_) => activityBloc,
        child: BlocBuilder<StaffActivityBloc, StaffActivityState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case InitialStaffActivityState:
              case LoadingStaffActivityState:
              case LoadedStaffActivityState:
              case ErrorLoadingStaffActivityState:
              default:
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          activityBloc.pagingController.refresh();
                        },
                        child: PagedListView<int, StaffAttendanceEntity?>(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            pagingController: activityBloc.pagingController,
                            builderDelegate: PagedChildBuilderDelegate(
                                noItemsFoundIndicatorBuilder: (_) => ShowError(
                                    failure: NoDataFailure(
                                        message: NoDataException().message),
                                    ErrorShowType: ErrorShowType.Vertical),
                                firstPageErrorIndicatorBuilder: (context) =>
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 200.0, left: 30, right: 30),
                                      child: ShowError(
                                          failure: activityBloc
                                              .pagingController.error,
                                          ErrorShowType: ErrorShowType.Vertical,
                                          onRetry: () => activityBloc
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
                                              child:
                                                  const StaffAttendanceCard(),
                                            )),
                                itemBuilder: ((context, item, index) => Padding(
                                      padding: EdgeInsets.only(
                                          top: index == 0 ? 0 : 10,
                                          bottom: index ==
                                                  (activityBloc
                                                              .pagingController
                                                              .itemList
                                                              ?.length ??
                                                          1) -
                                                      1
                                              ? 20
                                              : 0,
                                          left: 16,
                                          right: 16),
                                      child:
                                          // item?.Notice != null
                                          //     ? NoticeActivityCard(
                                          //         activity: item,
                                          //         showDate: index == 0 ||
                                          //             (index > 0 &&
                                          //                 activityBloc
                                          //                         .pagingController
                                          //                         .itemList![
                                          //                             index - 1]!
                                          //                         .created
                                          //                         .difference(
                                          //                             item!.created)
                                          //                         .inDays !=
                                          //                     0),
                                          //       )
                                          //     :
                                          StaffAttendanceCard(
                                              attendance: item,
                                              showDate: index == 0 ||
                                                  (index > 0 &&
                                                      activityBloc
                                                              .pagingController
                                                              .itemList![
                                                                  index - 1]!
                                                              .createdAt()
                                                              .difference(item!
                                                                  .createdAt())
                                                              .inDays !=
                                                          0)),
                                    )))),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
