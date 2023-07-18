import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/widgets/custom.shimmer.dart';

class StaffActivityCard extends StatefulWidget {
  const StaffActivityCard({super.key, this.attendance, this.showDate = true});
  final StaffActivityEntity? attendance;
  final bool showDate;

  @override
  State<StaffActivityCard> createState() => _StaffActivityCardState();
}

class _StaffActivityCardState extends State<StaffActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.attendance != null && widget.showDate)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 20),
              child: CustomShimmer(
                show: widget.attendance == null,
                child: Text(
                  (DateFormat('yyyy-MM-dd'))
                      .format(widget.attendance?.created ?? DateTime.now()),
                  textAlign: TextAlign.left,
                ),
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
                              show: widget.attendance == null,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  widget.attendance?.user?.avatar ??
                                      'assets/img/person.jpeg',
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
                                      show: widget.attendance == null,
                                      child: Text(
                                        widget.attendance?.user?.name ??
                                            '----------------',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                backgroundColor:
                                                    widget.attendance == null
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onBackground
                                                        : null),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomShimmer(
                                      show: widget.attendance == null,
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        radius: 3,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    CustomShimmer(
                                      show: widget.attendance == null,
                                      child: Text(
                                        widget.attendance?.user?.position ??
                                            'House Owner',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                backgroundColor:
                                                    widget.attendance == null
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : null,
                                                color: Theme.of(context)
                                                    .disabledColor),
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
                                        show: widget.attendance == null,
                                        child: Material(
                                          color: Colors.grey,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/icon/exit.png',
                                                  width: 12,
                                                  height: 12,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  'Left',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          backgroundColor: widget
                                                                      .attendance ==
                                                                  null
                                                              ? Theme.of(
                                                                      context)
                                                                  .dividerColor
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
                                        show: widget.attendance == null,
                                        child: Text(
                                          widget.attendance?.created != null
                                              ? (widget.attendance!.created!
                                                          .difference(
                                                              DateTime.now())
                                                          .inDays !=
                                                      0
                                                  ? (DateFormat.yMMMMEEEEd()
                                                      .format(widget.attendance!
                                                          .created!))
                                                  : timeago.format(
                                                      widget
                                                          .attendance!.created!,
                                                    ))
                                              : '...................',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  backgroundColor:
                                                      widget.attendance == null
                                                          ? Theme.of(context)
                                                              .hintColor
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: CustomShimmer(
                            show: widget.attendance == null,
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 1),
                                right: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 1),
                              )),
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
                                    show: widget.attendance == null,
                                    child: Icon(
                                      Icons.calendar_today_rounded,
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
                                    show: widget.attendance == null,
                                    child: Text(
                                      'Attendance',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              backgroundColor:
                                                  widget.attendance == null
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onBackground
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
