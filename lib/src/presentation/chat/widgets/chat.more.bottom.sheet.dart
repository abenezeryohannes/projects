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

class ChatMoreBottomSheet extends StatefulWidget {
  const ChatMoreBottomSheet({super.key, this.user});
  final UserEntity? user;
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

  List<Widget> _body(BuildContext context) {
    return [
      Padding(
        padding:
            const EdgeInsets.only(left: 20.0, top: 10, right: 20, bottom: 10),
        child: CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(
              Api.getMedia(widget.user?.avatar ?? 'img/placeholder.jpg')),
        ),
      ),
      Text(widget.user?.fullName ?? context.tr('anonymous'),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold)),
      if (widget.user != null)
        Text(widget.user!.phoneNumber,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).disabledColor)),
      BigTextButton(
        onClick: () {
          context.pushTransparentRoute(const AddCompanyPage());
        },
        textWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icon/add_company.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Add your business',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        horizontalMargin:
            const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
        backgroudColor: Theme.of(context).colorScheme.secondary,
        borderColor: Theme.of(context).colorScheme.secondary,
        cornerRadius: 200,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
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
                    onClick: () {
                      signOut();
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 10),
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

  void signOut() async {
    final signout = getIt<SignOutUseCase>();
    final result = await signout(param: const SignOutUseCaseParam());
    result?.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      Get.offAll(const ChatPage());
    });
  }

  void deleteAccount() async {
    if (widget.user == null) return;
    final deleteUserUsecase = getIt<DeleteUserUsecase>();
    final result = await deleteUserUsecase(
        param: DeleteUserUsecaseParam(user: widget.user!));
    result?.fold((l) {
      AppSnackBar.failure(failure: l);
    }, (r) {
      Get.offAll(const ChatPage());
    });
  }
}
