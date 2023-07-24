import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/errors/exceptions.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/widgets/show.error.dart';
import 'package:rnginfra/src/guards/patroll/presentation/patrolls_list/widgets/patroll.card.dart';
import 'package:rnginfra/src/guards/patroll/presentation/patrolls_list/widgets/patroll.date.picker.dart';

import '../../../domain/entitites/patroll.entity.dart';
import '../../scan_patrolls/page/scan.patroll.page.dart';
import '../bloc/patroll_bloc.dart';

class GuardPatrollPage extends StatefulWidget {
  const GuardPatrollPage({super.key});

  @override
  State<GuardPatrollPage> createState() => _GuardPatrollPageState();
}

class _GuardPatrollPageState extends State<GuardPatrollPage> {
  late PatrollBloc patrollBloc;

  @override
  void initState() {
    patrollBloc = getIt<PatrollBloc>();

    patrollBloc.pagingController.addPageRequestListener((pageKey) {
      patrollBloc.add(OnLoadPatrollEvent(
          page: pageKey,
          startTime: patrollBloc.selectedDay,
          endTime: patrollBloc.selectedDay?.add(const Duration(days: 1)),
          limit: patrollBloc.pageLimit));
    });
    super.initState();
  }

  @override
  void dispose() {
    patrollBloc.close();
    super.dispose();
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
                        builder: (context) => const ScanPatrollPage()));
              },
              icon: Icon(
                Icons.add,
                size: 24,
                color: Theme.of(context).colorScheme.secondary,
              )),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => PatrollDatePicker(
                          date: patrollBloc.selectedDay ?? DateTime.now(),
                          onDatePicked: (DateTime date) {
                            patrollBloc.selectedDay = date;
                            patrollBloc.pagingController.refresh();
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
              'Patrolling',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
      body: BlocProvider(
        create: (_) => patrollBloc,
        child: BlocBuilder<PatrollBloc, PatrollState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case InitialPatrollState:
              case LoadingPatrollState:
              case LoadedPatrollState:
              case ErrorLoadingPatrollState:
              default:
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          if (!patrollBloc.isClosed) {
                            patrollBloc.pagingController.refresh();
                          }
                        },
                        child: PagedListView<int, PatrollEntity?>(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            pagingController: patrollBloc.pagingController,
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
                                          failure: patrollBloc
                                              .pagingController.error,
                                          ErrorShowType: ErrorShowType.Vertical,
                                          onRetry: () => patrollBloc
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
                                              child: const PatrollCard(),
                                            )),
                                itemBuilder: ((context, item, index) => Padding(
                                      padding: EdgeInsets.only(
                                          top: index == 0 ? 0 : 5,
                                          bottom: index ==
                                                  (patrollBloc
                                                              .pagingController
                                                              .itemList
                                                              ?.length ??
                                                          1) -
                                                      1
                                              ? 200
                                              : 0,
                                          left: 10,
                                          right: 10),
                                      child: PatrollCard(
                                          patroll: item,
                                          showDate: index == 0 ||
                                              (index > 0 &&
                                                  patrollBloc
                                                          .pagingController
                                                          .itemList![index - 1]!
                                                          .created
                                                          .difference(
                                                              item!.created)
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
