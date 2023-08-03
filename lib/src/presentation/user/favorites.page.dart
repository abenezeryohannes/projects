import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/presentation/company/business.card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
      child: Scaffold(
        appBar: _appBar(),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, int) {
              return const Padding(
                padding: EdgeInsets.only(top: 24),
                child: BusinessCard(),
              );
            }),
      ),
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
}
