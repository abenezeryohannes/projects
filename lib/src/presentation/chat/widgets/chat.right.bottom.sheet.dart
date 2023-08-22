import 'package:dismissible_page/dismissible_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linko/src/presentation/privacy.bottom.sheet.dart';
import 'package:linko/src/presentation/user/change.language.dialog.dart';
import '../../../domain/user/entities/user.entity.dart';
import '../../about.bottom.sheet.dart';
import '../../../appcore/widgets/bottom.sheet.button.dart';
import '../../auth/pages/auth.page.dart';
import '../../user/favorites.page.dart';
import 'package:get/get.dart';
import '../chat.page.dart';
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
        child: Directionality(
          textDirection: TextDirection.ltr,
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                ),
                ..._myAccount(context)
              ]),
        ));
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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 20,
            ),
            BottomSheetButton(
                title: ('my_favorites').tr,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * (2 / 12),
                    right: MediaQuery.of(context).size.width * (2 / 12),
                    bottom: 20),
                icon: 'assets/icon/heart.png',
                onClick: () {
                  if (askFroAuth()) {
                    context.pushTransparentRoute(const FavoritesPage());
                  }
                }),
            Container(
              color: Theme.of(context).hoverColor,
              height: 1,
              width: MediaQuery.of(context).size.width * (8 / 12),
            ),
            BottomSheetButton(
                title: ('history').tr,
                icon: 'assets/icon/history.png',
                onClick: () {
                  if (askFroAuth()) {
                    context.pushTransparentRoute(const HistoryPage());
                  }
                }),
            Container(
              color: Theme.of(context).hoverColor,
              height: 1,
              width: MediaQuery.of(context).size.width * (8 / 12),
            ),
            BottomSheetButton(
                title: ('about_linko').tr,
                icon: 'assets/icon/about.png',
                onClick: () {
                  context.pushTransparentRoute(const AboutBottomSheet());
                }),
            Container(
              color: Theme.of(context).hoverColor,
              height: 1,
              width: MediaQuery.of(context).size.width * (8 / 12),
            ),
            const SizedBox(
              height: 10,
            ),
            BottomSheetButton(
                title: ('change_language').tr,
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
            Container(
              color: Theme.of(context).hoverColor,
              height: 1,
              width: MediaQuery.of(context).size.width * (8 / 12),
            ),
            BottomSheetButton(
                title: ('privacy_and_terms').tr,
                icon: 'assets/icon/privacy_and_terms.png',
                onClick: () {
                  context.pushTransparentRoute(const PrivacyBottomSheet());
                }),
            const SizedBox(
              height: 20,
            ),
            Text(
              ('made_by').tr,
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

  bool askFroAuth() {
    if (FirebaseAuth.instance.currentUser == null ||
        GetStorage().read('token') == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AuthPage(onAuthentication: () {
                    Get.offAll(const ChatPage());
                  })));
      return false;
    } else {
      return true;
    }
  }
}
