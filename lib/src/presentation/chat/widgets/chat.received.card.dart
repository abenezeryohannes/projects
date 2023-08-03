import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';

class ChatReceivedCard extends StatefulWidget {
  const ChatReceivedCard({super.key, this.chat});
  final ChatEntity? chat;
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
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.chat?.data ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary)),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(time(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSecondary)),
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
