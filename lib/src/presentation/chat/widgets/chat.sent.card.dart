import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linko/src/appcore/widgets/app.alert.dart';
// import 'package:intl/intl.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';
import 'package:intl/intl.dart' as intl;
import '../../../appcore/network/api.dart';

class ChatSentCard extends StatefulWidget {
  const ChatSentCard(
      {super.key, this.chat, required this.onClear, this.canClear = true});
  final ChatEntity? chat;
  final Function(int id) onClear;
  final bool canClear;
  @override
  State<ChatSentCard> createState() => _ChatSentCardState();
}

class _ChatSentCardState extends State<ChatSentCard> {
  @override
  Widget build(BuildContext context) {
    if ((widget.chat?.type ?? 'text') == 'text') {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 10),
        child: Directionality(
          textDirection: TextDirection.ltr,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 50,
                                width: 30,
                              ),
                              Flexible(
                                // padding: const EdgeInsets.only(left: 30, top: 0),
                                child: Text(widget.chat?.data ?? '',
                                    maxLines: 30,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                            color: Color(0xFFECECEC),
                            borderRadius:
                                BorderRadius.all(Radius.circular(200))),
                        child: InkWell(
                          onTap: () {
                            AppAlert().show(
                                context: context,
                                title: 'are_you_sure'.tr,
                                body: 'delete_my_chat_desc'.tr,
                                yes: 'yes_am_sure'.tr,
                                no: 'nevermind'.tr,
                                onYes: () {
                                  if (widget.chat != null) {
                                    widget.onClear(widget.chat!.id);
                                  }
                                  Navigator.maybePop(context);
                                },
                                onNo: () {
                                  Navigator.maybePop(context);
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icon/erase.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }

  String time() {
    if (widget.chat?.createdAt == null) {
      return 'sending...';
    } else {
      return intl.DateFormat('hh:mm a').format(widget.chat!.createdAt);
    }
  }
}
