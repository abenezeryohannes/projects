import 'package:dismissible_page/dismissible_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linko/injectable/getit.dart';
import 'package:linko/src/appcore/widgets/app.snackbar.dart';
import 'package:linko/src/domain/auth/usecases/sign.out.usecase.dart';
import 'package:linko/src/domain/user/usecases/delete.user.usecase.dart';
import 'package:linko/src/presentation/chat/chat.page.dart';
import 'package:linko/src/presentation/privacy.bottom.sheet.dart';
import 'package:linko/src/presentation/user/change.language.dialog.dart';
import '../../../appcore/network/api.dart';
import '../../../domain/user/entities/user.entity.dart';
import '../../about.bottom.sheet.dart';
import '../../company/add.company.page.dart';
import '../../../appcore/widgets/bottom.sheet.button.dart';
import '../../../appcore/widgets/big.text.button.dart';
import '../../user/favorites.page.dart';
import '../history.page.dart';

class ChatRightBottomSheet extends StatefulWidget {
  const ChatRightBottomSheet({super.key, this.user});
  final UserEntity? user;
  @override
  State<ChatRightBottomSheet> createState() => _ChatRightBottomSheetState();
}

enum BottomSheetType { MAIN, USER_ACCOUNT }

class _ChatRightBottomSheetState extends State<ChatRightBottomSheet> {
  late BottomSheetType viewType = BottomSheetType.MAIN;
  @override
  void initState() {
    viewType = BottomSheetType.USER_ACCOUNT;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * (6 / 12),
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
              ..._myAccount(context)
            ]));
  }

  List<Widget> _myAccount(BuildContext context) {
    return [
      // Row(
      //   children: [
      //     Padding(
      //         padding: const EdgeInsets.only(left: 20.0, bottom: 5),
      //         child: IconButton(
      //             onPressed: () {
      //               Navigator.maybePop(context);
      //             },
      //             icon: Icon(
      //               Icons.chevron_left,
      //               size: 32,
      //               color: Theme.of(context).disabledColor,
      //             ))),
      //   ],
      // ),

      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
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
            const SizedBox(
              height: 40,
            ),
            BottomSheetButton(
                title: 'Change language',
                icon: 'assets/icon/language.png',
                onClick: () {
                  showDialog(
                    context: context,
                    builder: (_) => const Dialog(
                        insetPadding: EdgeInsets.only(bottom: 200),
                        backgroundColor: Colors.transparent,
                        child: ChangeLanguageDialog()),
                  );
                  // Get.dialog(const ChangeLanguageDialog());
                }),
            BottomSheetButton(
                title: 'Privacy and terms',
                icon: 'assets/icon/privacy_and_terms.png',
                onClick: () {
                  context.pushTransparentRoute(const PrivacyBottomSheet());
                }),
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
}
