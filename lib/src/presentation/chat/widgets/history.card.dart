import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linko/src/appcore/widgets/custom.shimmer.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';

import '../../../appcore/dtos/wrapper.dto.dart';
import '../../../domain/company/entities/company.entity.dart';
import '../../company/business.card.dart';
import 'chat.received.card.dart';
import 'chat.sent.card.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key, this.chat, this.onClick, this.responses});
  final Function? onClick;
  final ChatEntity? chat;
  final List<ChatEntity>? responses;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool _showReply = false;

  @override
  void initState() {
    _showReply = false;
    super.initState();
  }

  _body() {
    return ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0.0),
        itemCount: widget.responses?.length ?? 0,
        itemBuilder: (context, i) {
          if (i > (widget.responses?.length ?? 0) - 1) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                    width: 24, height: 24, child: CircularProgressIndicator()),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: showChatItem(
              widget.responses?[i],
            ),
          );
        });
  }

  Widget showChatItem(ChatEntity? chat) {
    if (chat == null) return const SizedBox();
    if (chat.type != 'text') {
      if (chat.data == null || chat.data!.trim().isEmpty) {
        return const SizedBox();
      }
      final decoded = json.decode(chat.data!);
      WrapperDto<CompanyEntity?> wrapper =
          WrapperDto<CompanyEntity?>.fromJson(decoded);
      if (wrapper.datas == null) return const SizedBox();
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...wrapper.datas!.map((company) {
            return BusinessCard(
              company: company,
            );
          })
        ],
      );
    } else {
      if (chat.sender == null) {
        return ChatReceivedCard(
          chat: chat,
        );
      } else {
        return ChatSentCard(chat: chat);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if (widget.onClick != null) {
              widget.onClick!();
            }
            setState(() {
              _showReply = !_showReply;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: MediaQuery.of(context).size.width * (1 / 12)),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.chat?.data != null)
                        Flexible(
                          child: Text(
                            widget.chat!.data!,
                            maxLines: 10,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                          ),
                        ),
                      if (widget.chat?.data == null)
                        CustomShimmer(
                            show: widget.chat?.data == null,
                            child: Text(
                              widget.chat?.data ?? '.........................',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    backgroundColor: (widget.chat?.data == null)
                                        ? Theme.of(context).disabledColor
                                        : Colors.transparent,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            )),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (widget.responses != null && widget.responses!.isNotEmpty)
                  CustomShimmer(
                    show: widget.chat?.data == null,
                    child: Icon(
                      Icons.chevron_right,
                      size: 24,
                      color: Theme.of(context).disabledColor,
                    ),
                  )
              ],
            ),
          ),
        ),
        if (_showReply) _body()
      ],
    );
  }
}
