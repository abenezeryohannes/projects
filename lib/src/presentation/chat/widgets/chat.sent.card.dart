import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';

import '../../../appcore/network/api.dart';

class ChatSentCard extends StatefulWidget {
  const ChatSentCard({super.key, this.chat});
  final ChatEntity? chat;
  @override
  State<ChatSentCard> createState() => _ChatSentCardState();
}

class _ChatSentCardState extends State<ChatSentCard> {
  @override
  Widget build(BuildContext context) {
    if ((widget.chat?.type ?? 'text') == 'text') {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * (10 / 12)),
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 12),
              decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
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
                        backgroundImage: NetworkImage(Api.getMedia(
                            widget.chat?.sender?.avatar ??
                                'img/placeholder.jpg')),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        widget.chat?.sender?.fullName ?? 'Anonymous',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 0),
                    child: Text(widget.chat?.data ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground)),
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(time(),
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodySmall!
                  //             .copyWith(
                  //                 fontSize: 10,
                  //                 color: Theme.of(context)
                  //                     .colorScheme
                  //                     .onBackground)),
                  //   ],
                  // ),
                ],
              ),
            ),
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
