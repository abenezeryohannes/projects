import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/infrastructure/chat/dtos/chat.dto.dart';

import '../../../appcore/widgets/text.input.form.dart';
import '../../../domain/user/entities/user.entity.dart';
import '../../auth/pages/auth.page.dart';

class ChatBottom extends StatefulWidget {
  ChatBottom({super.key, this.user, required this.sendMessage});
  final UserEntity? user;
  final Function(ChatDto) sendMessage;
  final state = _ChatBottomState();
  @override
  State<ChatBottom> createState() => state;

  void clear() {
    state.clear();
  }
}

class _ChatBottomState extends State<ChatBottom> {
  String text = '';
  TextInputForm? textInputForm;

  @override
  Widget build(BuildContext context) {
    textInputForm ??= initTextForm(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * (9 / 12),
              child: textInputForm),
        ),
        Material(
            color: Theme.of(context).colorScheme.secondary,
            elevation: 1,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: IconButton(
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser == null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AuthPage(onAuthentication: () {
                                  Navigator.maybePop(context);
                                })));
                  } else {
                    widget.sendMessage(
                        ChatDto(senderID: widget.user?.id ?? -1, data: text));
                  }
                },
                icon: Transform.rotate(
                  angle: -.50,
                  child: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                )))
      ],
    );
  }

  TextInputForm initTextForm(BuildContext context) {
    return TextInputForm(
      fillColor: Theme.of(context).cardColor,
      placeholder: 'Message',
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      onChanged: (String val) {
        setState(() {
          text = val;
        });
      },
      initialValue: text,
      radius: 30,
      suffixIcon: const Icon(
        Icons.graphic_eq,
      ),
    );
  }

  void clear() {
    if (mounted) {
      setState(() {
        textInputForm?.clear();
      });
    }
  }
}
