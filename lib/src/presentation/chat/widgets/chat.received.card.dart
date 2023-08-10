import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';

import '../../../appcore/network/api.dart';

class ChatReceivedCard extends StatefulWidget {
  const ChatReceivedCard({super.key, this.chat, this.showSender = false});
  final ChatEntity? chat;
  final bool showSender;
  @override
  State<ChatReceivedCard> createState() => _ChatReceivedCardState();
}

class _ChatReceivedCardState extends State<ChatReceivedCard> {
  @override
  Widget build(BuildContext context) {
    if ((widget.chat?.type ?? 'text') == 'text') {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              width: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 8),
            //   child: (widget.showSender || true)
            //       ? CircleAvatar(
            //           radius: 20,
            //           backgroundColor: Theme.of(context).colorScheme.background,
            //           backgroundImage:
            //               NetworkImage(Api.getMedia('img/logo.png')),
            //         )
            //       : const SizedBox(
            //           width: 40,
            //         ),
            // ),
            Container(
              constraints: BoxConstraints(
                  maxWidth:
                      ((MediaQuery.of(context).size.width * (10 / 12) - 45))),
              margin: const EdgeInsets.only(bottom: 2),
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        backgroundImage:
                            NetworkImage(Api.getMedia('img/logo.png')),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Linko',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(widget.chat?.data ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground)),
                  ),
                  // const SizedBox(
                  //   height: 3,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 30.0),
                  //   child: Text(time(),
                  //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  //           fontSize: 10,
                  //           color: Theme.of(context).colorScheme.onBackground)),
                  // ),
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      );
    }
    return const SizedBox();
  }

  String time() {
    if (widget.chat?.createdAt == null) {
      return 'sending...';
    } else {
      return DateFormat('hh:mm a').format(widget.chat!.createdAt);
    }
  }
}
