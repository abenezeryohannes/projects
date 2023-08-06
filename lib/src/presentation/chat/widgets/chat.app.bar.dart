import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../appcore/network/api.dart';
import '../../../domain/user/entities/user.entity.dart';
import '../../auth/pages/auth.page.dart';
import '../../user/profile.bottom.sheet.dart';
import 'chat.more.bottom.sheet.dart';

class ChatAppBar extends StatefulWidget {
  const ChatAppBar({super.key, this.user});
  final UserEntity? user;
  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                      isScrollControlled: true,
                      builder: (context) => Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: const ProfileBottomSheet(),
                          ));
                }
              },
              child: CircleAvatar(
                radius: 21,
                backgroundImage: NetworkImage(
                  Api.getMedia(widget.user?.avatar ?? 'img/placeholder.jpg'),
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
                          builder: (context) => ChatMoreBottomSheet(
                                user: widget.user,
                              ));
                    },
                    icon: Icon(
                      Icons.more_horiz,
                      size: 36,
                      color: Theme.of(context).disabledColor,
                    )))),
      ],
    );
  }
}
