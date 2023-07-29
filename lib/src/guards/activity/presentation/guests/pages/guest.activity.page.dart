import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/guest.activity.entity.dart';

import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/show.error.dart';
import '../bloc/guest_activity_bloc.dart';
import '../widgets/cab.guest.activity.card.dart';
import '../widgets/guest.activity.date.picker.dart';

class GuardGuestActivityPage extends StatefulWidget {
  GuardGuestActivityPage({super.key});
  final _activityPageState = _GuardGuestActivityPageState();

  @override
  State<GuardGuestActivityPage> createState() => _activityPageState;

  void reload() {
    _activityPageState.reload();
  }
}

class _GuardGuestActivityPageState extends State<GuardGuestActivityPage> {
  GuestActivityBloc activityBloc = getIt<GuestActivityBloc>();

  void reload() {
    if (!activityBloc.isClosed) {
      activityBloc.pagingController.refresh();
    }
  }

  @override
  void initState() {
    activityBloc = getIt<GuestActivityBloc>();

    activityBloc.pagingController.addPageRequestListener((pageKey) {
      activityBloc.add(OnLoadGuestctivityEvent(
          page: pageKey,
          limit: activityBloc.pageLimit,
          startTime: activityBloc.selectedDay,
          endTime: activityBloc.selectedDay?.add(const Duration(days: 1))));
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
                    builder: (ctx) => GuestActivityDatePicker(
                          date: activityBloc.selectedDay ?? DateTime.now(),
                          onDatePicked: (DateTime date) {
                            activityBloc.selectedDay = date;
                            activityBloc.pagingController.refresh();
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
              'Guest Activities',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
      //body: //const GuardAddGuestActivity()
      body: BlocProvider(
        create: (_) => activityBloc,
        child: BlocBuilder<GuestActivityBloc, GuestActivityState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case InitialGuestActivityState:
              case LoadingGuestActivityState:
              case LoadedGuestActivityState:
              case ErrorLoadingGuestActivityState:
              default:
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          if (!activityBloc.isClosed) {
                            activityBloc.pagingController.refresh();
                          }
                        },
                        child: PagedListView<int, GuestActivityEntity?>(
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
                                                  const CabGuestActivityCard(),
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
                                              ? 100
                                              : 0,
                                          left: 16,
                                          right: 16),
                                      child: CabGuestActivityCard(
                                          activity: item,
                                          showDate: index == 0 ||
                                              (index > 0 &&
                                                  activityBloc.pagingController
                                                          .itemList![index - 1]!
                                                          .createdAt()
                                                          .difference(
                                                              item!.createdAt())
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
