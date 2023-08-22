import 'package:dismissible_page/dismissible_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linko/injectable/getit.dart';
import 'package:linko/src/appcore/widgets/app.alert.dart';
import 'package:linko/src/appcore/widgets/app.snackbar.dart';
import 'package:linko/src/domain/auth/usecases/sign.out.usecase.dart';
import 'package:linko/src/domain/user/usecases/delete.user.usecase.dart';
import 'package:linko/src/presentation/chat/chat.page.dart';
import '../../../appcore/network/api.dart';
import '../../../domain/user/entities/user.entity.dart';
import '../../auth/pages/auth.page.dart';
import '../../company/add.company.page.dart';
import '../../../appcore/widgets/bottom.sheet.button.dart';
import '../../../appcore/widgets/big.text.button.dart';

class ChatLeftBottomSheet extends StatefulWidget {
  const ChatLeftBottomSheet({super.key, this.user});
  final UserEntity? user;
  @override
  State<ChatLeftBottomSheet> createState() => _ChatLeftBottomSheetState();
}

enum BottomSheetType { MAIN, USER_ACCOUNT }

class _ChatLeftBottomSheetState extends State<ChatLeftBottomSheet> {
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
                ..._body(context)
              ]),
        ));
  }

  List<Widget> _body(BuildContext context) {
    return [
      Padding(
        padding:
            const EdgeInsets.only(left: 20.0, top: 10, right: 20, bottom: 10),
        child: (widget.user?.avatar == null)
            ? CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                radius: 36,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).cardColor,
                  backgroundImage: const AssetImage('assets/icon/user.png'),
                ),
              )
            : CircleAvatar(
                radius: 36,
                backgroundColor: Theme.of(context).cardColor,
                backgroundImage: NetworkImage(
                  Api.getMedia(widget.user?.avatar ?? 'icon/user.png'),
                ),
              ),
      ),
      Text(widget.user?.fullName ?? ('anonymous').tr,
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
          if (askFroAuth()) {
            context.pushTransparentRoute(const AddCompanyPage());
          }
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
              ('add_your_business').tr,
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
                const SizedBox(
                  height: 6,
                ),
                BottomSheetButton(
                    title: ('my_account').tr,
                    icon: 'assets/icon/user2.png',
                    onClick: () {
                      if (askFroAuth()) {
                        Navigator.maybePop<String>(context, 'profile');
                      }
                    }),
                const SizedBox(
                  height: 6,
                ),
                BottomSheetButton(
                    title: ('sign_out').tr,
                    icon: 'assets/icon/power.png',
                    onClick: () {
                      if (askFroAuth()) {
                        AppAlert().show(
                            context: context,
                            title: ('are_you_sure').tr,
                            body: 'sign_out_desc'.tr,
                            yes: 'yes_am_sure'.tr,
                            no: 'nevermind'.tr,
                            onYes: () {
                              signOut();
                            },
                            onNo: () {
                              Navigator.maybePop(context);
                            });
                      }
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 10),
              child: BottomSheetButton(
                  title: ('delete_my_account').tr,
                  icon: 'assets/icon/delete.png',
                  cheviron: false,
                  color: Theme.of(context).colorScheme.secondary,
                  icaonBackgroundColor: Theme.of(context).colorScheme.tertiary,
                  onClick: () {
                    if (askFroAuth()) {
                      AppAlert().show(
                          context: context,
                          title: ('are_you_sure').tr,
                          body: 'delete_user_desc'.tr,
                          yes: 'yes_am_sure'.tr,
                          no: 'nevermind'.tr,
                          onYes: () {
                            deleteAccount();
                          },
                          onNo: () {
                            Navigator.maybePop(context);
                          });
                    }
                  }),
            ),
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
