import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/widgets/custom.shimmer.dart';

class GuardGuestActivityCard extends StatefulWidget {
  const GuardGuestActivityCard(
      {super.key, this.activity, this.showDate = true});
  final ActivityEntity? activity;
  final bool showDate;

  @override
  State<GuardGuestActivityCard> createState() => _GuardGuestActivityCardState();
}

class _GuardGuestActivityCardState extends State<GuardGuestActivityCard> {
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
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey.shade100,
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(int.parse(widget.activity
                                                  ?.ActivityType?.color ??
                                              '0xFF444336'))),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1000))),
                                  child: Image.asset(
                                    widget.activity?.ActivityType?.icon ??
                                        'assets/img/user_account.png',
                                    width: 30,
                                    height: 30,
                                    color: Color(int.parse(
                                        widget.activity?.ActivityType?.color ??
                                            '0xFF444336')),
                                  ),
                                ),
                              ),
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
                                        widget.activity?.ActivityType?.name ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                backgroundColor:
                                                    widget.activity == null
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : null),
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                    // CircleAvatar(
                                    //   backgroundColor: Theme.of(context)
                                    //       .colorScheme
                                    //       .onBackground,
                                    //   radius: 3,
                                    // ),
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
                                          color: Color(int.parse(
                                              widget.activity?.Action?.color ??
                                                  '0xFFf4f4f4')),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (widget.activity != null)
                                                  Image.asset(
                                                    widget.activity?.Action
                                                            ?.icon ??
                                                        'assets/icon/exit.png',
                                                    width: 12,
                                                    height: 12,
                                                    color: Colors.white,
                                                  ),
                                                SizedBox(
                                                  height:
                                                      widget.activity == null
                                                          ? 14
                                                          : 4,
                                                  width: widget.activity == null
                                                      ? 30
                                                      : 4,
                                                ),
                                                if (widget.activity != null)
                                                  Text(
                                                    widget.activity?.Action
                                                            ?.name ??
                                                        '----',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
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
                                              : '...................',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  backgroundColor:
                                                      widget.activity == null
                                                          ? Theme.of(context)
                                                              .hintColor
                                                          : null,
                                                  color: Theme.of(context)
                                                      .hintColor),
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
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomShimmer(
                            show: widget.activity == null,
                            child: CircleAvatar(
                                radius: 14,
                                backgroundImage: AssetImage(
                                    widget.activity?.Publisher.avatar ??
                                        'assets/img/person.jpeg')),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomShimmer(
                            show: widget.activity == null,
                            child: Text(
                              widget.activity?.Approval?.approver.name ??
                                  'Undetermined',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      backgroundColor: widget.activity == null
                                          ? Theme.of(context).hintColor
                                          : null),
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
                            child: CircleAvatar(
                                radius: 14,
                                backgroundImage:
                                    AssetImage('assets/img/user_account.png')),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomShimmer(
                            show: widget.activity == null,
                            child: Text(
                              '${(widget.activity?.Approval?.status ?? -1) == 1 ? 'Allowed By' : ((widget.activity?.Approval?.status ?? -1) == -1 ? 'Rejected By' : 'Waiting Approval From ')} Sasanka',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      backgroundColor: widget.activity == null
                                          ? Theme.of(context).hintColor
                                          : null,
                                      color: Theme.of(context).hintColor),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1),
                              right: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1),
                            )),
                            child: CustomShimmer(
                              show: widget.activity == null,
                              child: Icon(
                                Icons.phone,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Theme.of(context).dividerColor,
                                          width: 1))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomShimmer(
                                    show: widget.activity == null,
                                    child: Icon(
                                      (widget.activity?.Approval?.status ??
                                                  -1) ==
                                              1
                                          ? Icons.check
                                          : ((widget.activity?.Approval
                                                          ?.status ??
                                                      -1) ==
                                                  -1
                                              ? Icons.block
                                              : Icons.pending_actions_outlined),
                                      size: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomShimmer(
                                    show: widget.activity == null,
                                    child: Text(
                                      (widget.activity?.Approval?.status ??
                                                  -1) ==
                                              1
                                          ? 'Approved'
                                          : ((widget.activity?.Approval
                                                          ?.status ??
                                                      -1) ==
                                                  -1
                                              ? 'Wrong entry'
                                              : 'Waiting Approval'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              backgroundColor:
                                                  widget.activity == null
                                                      ? Theme.of(context)
                                                          .hintColor
                                                      : null),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ]);
  }
}
