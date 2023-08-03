import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';

import 'chat.sent.card.dart';

class ChatList extends StatefulWidget {
  const ChatList(
      {super.key,
      required this.controller,
      this.isAllLoaded = false,
      required this.chatList,
      required this.onLoadMoreChat});
  final ScrollController controller;
  final bool isAllLoaded;
  final List<ChatEntity> chatList;
  final Function onLoadMoreChat;
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (widget.controller.offset >=
              widget.controller.position.maxScrollExtent &&
          !widget.controller.position.outOfRange) {
        if (widget.isAllLoaded) return;
        widget.onLoadMoreChat();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0.0),
        controller: widget.controller,
        itemCount: (widget.isAllLoaded || widget.chatList.isEmpty)
            ? widget.chatList.length
            : widget.chatList.length + 1,
        itemBuilder: (context, i) {
          if (i > widget.chatList.length - 1) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                    width: 24, height: 24, child: CircularProgressIndicator()),
              ),
            );
          }
          return ChatSentCard(
            chat: widget.chatList[i],
          );
        });
  }
}
