import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/about.bottom.sheet.dart';
import 'package:linko/src/add.business.page.dart';
import 'package:linko/src/bottom.sheet.button.dart';
import 'package:linko/src/core/widgets/big.text.button.dart';
import 'package:linko/src/favorites.page.dart';
import 'package:linko/src/history.page.dart';

class ChatMoreBottomSheet extends StatefulWidget {
  const ChatMoreBottomSheet({super.key});

  @override
  State<ChatMoreBottomSheet> createState() => _ChatMoreBottomSheetState();
}

enum BottomSheetType { MAIN, USER_ACCOUNT }

class _ChatMoreBottomSheetState extends State<ChatMoreBottomSheet> {
  late BottomSheetType viewType = BottomSheetType.MAIN;
  @override
  void initState() {
    viewType = BottomSheetType.MAIN;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * (7 / 12),
        padding: const EdgeInsets.only(bottom: 34),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              if (viewType == BottomSheetType.MAIN)
                ..._body(context)
              else if (viewType == BottomSheetType.USER_ACCOUNT)
                ..._myAccount(context)
            ]));
  }

  List<Widget> _myAccount(BuildContext context) {
    return [
      Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 5),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      viewType = BottomSheetType.MAIN;
                    });
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: 32,
                    color: Theme.of(context).disabledColor,
                  ))),
        ],
      ),
      BottomSheetButton(
          title: 'My Favourites',
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * (2 / 12),
              right: MediaQuery.of(context).size.width * (2 / 12),
              bottom: 20),
          icon: 'assets/icon/heart.png',
          onClick: () {
            context.pushTransparentRoute(const FavoritesPage());
          }),
      BottomSheetButton(
          title: 'History',
          icon: 'assets/icon/history.png',
          onClick: () {
            context.pushTransparentRoute(const HistoryPage());
          }),
      BottomSheetButton(
          title: 'About Linko',
          icon: 'assets/icon/about.png',
          onClick: () {
            context.pushTransparentRoute(const AboutBottomSheet());
          }),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            BottomSheetButton(
                title: 'Change language',
                icon: 'assets/icon/language.png',
                onClick: () {}),
            BottomSheetButton(
                title: 'Privacy and terms',
                icon: 'assets/icon/privacy_and_terms.png',
                onClick: () {}),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Mayde by mo & mo',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).disabledColor),
            )
          ],
        ),
      )
    ];
  }

  List<Widget> _body(BuildContext context) {
    return [
      const Padding(
        padding: EdgeInsets.only(left: 20.0, top: 10, right: 20, bottom: 10),
        child: CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage('https://picsum.photos/200/300'),
        ),
      ),
      Text('Salem',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold)),
      Text('+965 50508080',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).disabledColor)),
      BigTextButton(
        onClick: () {
          context.pushTransparentRoute(const AddBusinessPage());
        },
        horizontalMargin:
            const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
        text: 'Add your business',
        backgroudColor: Theme.of(context).colorScheme.secondary,
        cornerRadius: 200,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                BottomSheetButton(
                    title: 'My account',
                    icon: 'assets/icon/user.png',
                    onClick: () {
                      setState(() {
                        viewType = BottomSheetType.USER_ACCOUNT;
                      });
                    }),
                BottomSheetButton(
                    title: 'Sign Out',
                    icon: 'assets/icon/power.png',
                    onClick: () {}),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 10),
              child: BottomSheetButton(
                  title: 'Delete my account',
                  icon: 'assets/icon/delete.png',
                  cheviron: false,
                  color: Colors.red,
                  onClick: () {}),
            ),
          ],
        ),
      )
    ];
  }
}
