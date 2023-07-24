import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/widgets/custom.shimmer.dart';

class TimeWithDate extends StatefulWidget {
  const TimeWithDate({super.key, this.time, this.title});
  final String? title;
  final DateTime? time;
  @override
  State<TimeWithDate> createState() => _TimeWithDateState();
}

class _TimeWithDateState extends State<TimeWithDate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.time == null ||
              (widget.title != null && widget.title!.isNotEmpty))
            CustomShimmer(
              show: widget.time == null,
              child: Text(
                widget.title ?? '.......',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    backgroundColor: widget.time == null
                        ? Theme.of(context).dividerColor
                        : null,
                    color: Theme.of(context).disabledColor),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
                top: (widget.time == null ||
                        (widget.title != null && widget.title!.isNotEmpty))
                    ? 8.0
                    : 0),
            child: CustomShimmer(
              show: widget.time == null,
              child: Text(
                widget.time != null
                    ? (DateFormat('MMM d, yyyy').format(widget.time!))
                        .replaceAll(',', 'th,')
                    : '...................',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    backgroundColor: widget.time == null
                        ? Theme.of(context).colorScheme.onBackground
                        : null,
                    color: Theme.of(context).hintColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CustomShimmer(
              show: widget.time == null,
              child: Text(
                widget.time != null
                    ? (widget.time!.difference(DateTime.now()).inDays != 0
                        ? (DateFormat('E, hh:mm a').format(widget.time!))
                        : timeago.format(
                            widget.time!,
                          ))
                    : '...................',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    backgroundColor: widget.time == null
                        ? Theme.of(context).colorScheme.onBackground
                        : null,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
