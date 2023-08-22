import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/widgets/app.snackbar.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:linko/src/domain/chat/usecases/clear.history.usecase.dart';
import 'package:linko/src/presentation/chat/widgets/chat.company.list.dart';
import 'package:linko/src/presentation/chat/widgets/chat.received.card.dart';

import '../../../../injectable/getit.dart';
import 'chat.sent.card.dart';

class ChatList extends StatefulWidget {
  const ChatList(
      {super.key,
      required this.controller,
      this.isAllLoaded = false,
      required this.chatList,
      required this.onLoadMoreChat,
      required this.removeChat});
  final ScrollController controller;
  final bool isAllLoaded;
  final Function(int) removeChat;
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListView.builder(
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
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator()),
                ),
              );
            }
            return showChatItem(
              widget.chatList[i],
            );
          }),
    );
  }

  Widget showChatItem(
    ChatEntity chat,
  ) {
    if (chat.type != 'text') {
      if (chat.data == null || chat.data!.trim().isEmpty) {
        return const SizedBox();
      }
      final decoded = json.decode(chat.data!);
      WrapperDto<int?> wrapper = WrapperDto<int?>.fromJson(decoded);
      if (wrapper.datas == null) return const SizedBox();
      return ChatCompanyList(controller: widget.controller, chat: chat);
    } else {
      if (chat.sender == null) {
        return ChatReceivedCard(
          key: Key(chat.toString()),
          chat: chat,
        );
      } else {
        return ChatSentCard(
          chat: chat,
          onClear: (int id) async {
            final usecase = getIt<ClearHistoryUsecase>();

            final result =
                await usecase(param: const ClearHistoryUsecaseNoParam());
            if (result == null) {
              AppSnackBar.failure(
                  failure: Failure(message: UnExpectedFailure().message));
              return;
            }
            result.fold((l) {
              AppSnackBar.failure(failure: l);
            }, (r) {
              widget.removeChat(id);
              // AppSnackBar.success()
            });
          },
        );
      }
    }
  }
}
