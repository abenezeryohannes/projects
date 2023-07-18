import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/widgets/custom.shimmer.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoticeActivityCard extends StatefulWidget {
  const NoticeActivityCard({super.key, this.activity, this.showDate = false});
  final ActivityEntity? activity;
  final bool showDate;

  @override
  State<NoticeActivityCard> createState() => _NoticeActivityCardState();
}

class _NoticeActivityCardState extends State<NoticeActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.activity != null && widget.showDate)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 20),
              child: Text(
                (DateFormat('yyyy-MM-dd')).format(widget.activity!.created),
                textAlign: TextAlign.left,
              ),
            ),
          Material(
              elevation: 1,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 20, bottom: 20, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: CustomShimmer(
                              show: widget.activity == null,
                              child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.amber,
                                  backgroundImage:
                                      AssetImage('assets/icon/note.png')),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomShimmer(
                                      show: widget.activity == null,
                                      child: Text(
                                        'Notice',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                backgroundColor:
                                                    widget.activity == null
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onBackground
                                                        : null),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10),
                                  child: Row(
                                    children: [
                                      CustomShimmer(
                                        show: widget.activity == null,
                                        child: Material(
                                          color: Colors.amber,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  widget.activity?.Notice
                                                          ?.noticeFor ??
                                                      'SOCIETY',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          backgroundColor: widget
                                                                      .activity ==
                                                                  null
                                                              ? Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onBackground
                                                              : null,
                                                          color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomShimmer(
                                        show: widget.activity == null,
                                        child: Text(
                                          widget.activity != null
                                              ? (widget.activity!.created
                                                          .difference(
                                                              DateTime.now())
                                                          .inDays !=
                                                      0
                                                  ? (DateFormat.yMMMMEEEEd()
                                                      .format(widget
                                                          .activity!.created))
                                                  : timeago.format(
                                                      widget.activity!.created,
                                                    ))
                                              : 'Unknown time',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  backgroundColor:
                                                      widget.activity == null
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .onBackground
                                                          : null,
                                                  color: Theme.of(context)
                                                      .disabledColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //more inco

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmer(
                            show: widget.activity == null,
                            child: Icon(
                              Icons.comment,
                              color: Theme.of(context).disabledColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: CustomShimmer(
                              show: widget.activity == null,
                              child: Text(
                                widget.activity?.Notice?.text ??
                                    '-------------------------------------\n---------------------\n------------------',
                                maxLines: 5,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        backgroundColor: widget.activity == null
                                            ? Theme.of(context).disabledColor
                                            : null),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomShimmer(
                            show: widget.activity == null,
                            child: Image.asset(
                              'assets/img/user_account.png',
                              width: 20,
                              height: 20,
                              color: widget.activity == null
                                  ? Theme.of(context).disabledColor
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomShimmer(
                            show: widget.activity == null,
                            child: Text(
                              'Published by ${widget.activity?.Publisher.name ?? 'Unknown'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      backgroundColor: widget.activity == null
                                          ? Theme.of(context).disabledColor
                                          : null),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ))
        ]);
  }
}
