import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:linko/injectable/getit.dart';
import 'package:linko/src/application/user/favorite.controller.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';
import 'package:linko/src/presentation/company/business.card.dart';

import '../../appcore/errors/exceptions.dart';
import '../../appcore/errors/failure.dart';
import '../../appcore/widgets/show.error.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoriteController controller;
  @override
  void initState() {
    controller = getIt<FavoriteController>();
    controller.find();
    controller.pagingController.addPageRequestListener((pageKey) {
      controller.findAll(page: pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        'My Favorites',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
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
              child: PagedListView<int, FavoriteEntity?>(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<FavoriteEntity?>(
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
                            BusinessCard(),
                            BusinessCard(),
                            BusinessCard(),
                            BusinessCard(),
                            BusinessCard(),
                            BusinessCard(),
                          ],
                        ),
                    itemBuilder: (context, item, index) => BusinessCard(
                          company: item?.company,
                        )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
