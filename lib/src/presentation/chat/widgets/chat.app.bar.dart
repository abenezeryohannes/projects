import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/presentation/chat/widgets/chat.right.bottom.sheet.dart';

import '../../../appcore/network/api.dart';
import '../../../domain/user/entities/user.entity.dart';
import '../../auth/pages/auth.page.dart';
import '../../user/profile.bottom.sheet.dart';
import 'chat.left.bottom.sheet.dart';

class ChatAppBar extends StatefulWidget {
  const ChatAppBar({super.key, this.user, required this.onRefresh});
  static bool refresh = false;
  final UserEntity? user;
  final Function onRefresh;
  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10, right: 20, bottom: 10),
              child: InkWell(
                onTap: () {
                  if (FirebaseAuth.instance.currentUser == null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AuthPage(onAuthentication: () {
                                  Navigator.maybePop(context);
                                })));
                  } else {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => ChatLeftBottomSheet(
                              user: widget.user,
                            )).then((value) {
                      if (ChatAppBar.refresh) {
                        widget.onRefresh();
                      }
                      if (value == 'profile') {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: const ProfileBottomSheet(),
                                )).then((value) {
                          if (ChatAppBar.refresh) {
                            widget.onRefresh();
                          }
                        });
                      }
                    });
                  }
                },
                child: (widget.user?.avatar == null)
                    ? CircleAvatar(
                        backgroundColor: Theme.of(context).cardColor,
                        radius: 24,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).cardColor,
                          backgroundImage:
                              const AssetImage('assets/icon/user.png'),
                        ),
                      )
                    : CircleAvatar(
                        radius: 24,
                        backgroundColor: Theme.of(context).cardColor,
                        backgroundImage: NetworkImage(
                          Api.getMedia(widget.user?.avatar ?? 'icon/user.png'),
                        ),
                      ),
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10, right: 20, bottom: 10),
              child: Material(
                  color: Theme.of(context).cardColor,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ChatRightBottomSheet(
                                  user: widget.user,
                                )).then((value) {
                          if (ChatAppBar.refresh) {
                            widget.onRefresh();
                          }
                          if (value == 'profile') {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: const ProfileBottomSheet(),
                                    )).then((value) {
                              if (ChatAppBar.refresh) {
                                widget.onRefresh();
                              }
                            });
                          }
                        });
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        size: 30,
                        color: Theme.of(context).disabledColor,
                      )))),
        ],
      ),
    );
  }
}
