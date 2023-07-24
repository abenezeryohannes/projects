import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/widgets/custom.shimmer.dart';

class ExitTimeInCard extends StatefulWidget {
  const ExitTimeInCard({super.key, this.time});
  final DateTime? time;
  @override
  State<ExitTimeInCard> createState() => _ExitTimeInCardState();
}

class _ExitTimeInCardState extends State<ExitTimeInCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Row(
        children: [
          CustomShimmer(
            show: widget.time == null,
            child: Material(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).colorScheme.error),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 14, right: 34.0, bottom: 4, top: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icon/exit.png',
                      width: 14,
                      height: 14,
                      // color: Colors.white,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Left',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          backgroundColor: widget.time == null
                              ? Theme.of(context).dividerColor
                              : null,
                          color: Theme.of(context).colorScheme.error),
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
            show: widget.time == null,
            child: Text(
              // widget.attendance?.created ??
              //     '...................',

              widget.time != null
                  ? (widget.time!.difference(DateTime.now()).inDays != 0
                      ? (DateFormat('E, hh:mm a ( dd / MM / yy )')
                          .format(widget.time!))
                      : timeago.format(
                          widget.time!,
                        ))
                  : '...................',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  backgroundColor: widget.time == null
                      ? Theme.of(context).colorScheme.onBackground
                      : null,
                  color: Theme.of(context).disabledColor),
            ),
          ),
        ],
      ),
    );
  }
}
