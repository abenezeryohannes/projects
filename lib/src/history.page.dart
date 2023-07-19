import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/bottom.sheet.button.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            BottomSheetButton(
                padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: MediaQuery.of(context).size.width * (1 / 12)),
                title: 'I wan\'t burger restaurants',
                onClick: () {}),
            BottomSheetButton(
                padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: MediaQuery.of(context).size.width * (1 / 12)),
                title: 'I need a cup of coffee',
                onClick: () {}),
            BottomSheetButton(
                padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: MediaQuery.of(context).size.width * (1 / 12)),
                title: 'Nearby cafe?',
                onClick: () {}),
            BottomSheetButton(
                padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: MediaQuery.of(context).size.width * (1 / 12)),
                title: 'I need catering',
                onClick: () {})
          ],
        ),
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
        'History',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {},
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
}
