import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/guards/core/widgets/time.with.date.dart';

import 'custom.shimmer.dart';

class EntryAndExitTime extends StatefulWidget {
  const EntryAndExitTime({super.key, this.entryTime, this.exitTime});
  final DateTime? entryTime;
  final DateTime? exitTime;
  @override
  State<EntryAndExitTime> createState() => _EntryAndExitTimeState();
}

class _EntryAndExitTimeState extends State<EntryAndExitTime> {
  @override
  Widget build(BuildContext context) {
    if (widget.entryTime != null &&
        widget.exitTime != null &&
        widget.entryTime!.difference(widget.exitTime!).inHours <= 24 &&
        widget.entryTime!.difference(widget.exitTime!).inHours >= -24) {
      return _sameDay();
    } else if (widget.entryTime != null &&
        widget.exitTime != null &&
        widget.entryTime!.difference(widget.exitTime!).inDays == 0) {
      return _diffrentDay();
    }
    return _diffrentDay();
  }

  Widget _diffrentDay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        TimeWithDate(
          time: widget.entryTime,
          title: '',
        ),
        if (widget.exitTime != null)
          Container(
            width: 1,
            height: 60,
            color: Theme.of(context).dividerColor,
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
        if (widget.exitTime != null)
          TimeWithDate(
            time: widget.exitTime,
            title: '',
          ),
      ],
    );
  }

  Widget _sameDay() {
    String timeDifference = (widget.exitTime == null)
        ? '--:--'
        : widget.exitTime!.difference(widget.entryTime!).toString();
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomShimmer(
                  show: widget.entryTime == null,
                  child: Text(
                    DateFormat('MMM d, yyyy')
                        .format(widget.entryTime!)
                        .replaceAll(',', 'th,'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        backgroundColor: widget.entryTime == null
                            ? Theme.of(context).dividerColor
                            : null,
                        color: Theme.of(context).disabledColor),
                  ),
                ),
              ),
              if (widget.exitTime != null)
                CustomShimmer(
                  show: widget.exitTime == null,
                  child: Text(
                    '${timeDifference.substring(0, timeDifference.lastIndexOf(':'))} total hrs',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        backgroundColor: widget.entryTime == null
                            ? Theme.of(context).dividerColor
                            : null,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
            ],
          ),
          Container(
            width: 1,
            height: 50,
            color: Theme.of(context).dividerColor,
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          if (widget.exitTime != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomShimmer(
                    show: widget.entryTime == null,
                    child: Text(
                      'In & Out',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          backgroundColor: widget.entryTime == null
                              ? Theme.of(context).dividerColor
                              : null,
                          color: Theme.of(context).disabledColor),
                    ),
                  ),
                ),
                if (widget.exitTime != null)
                  CustomShimmer(
                    show: widget.exitTime == null,
                    child: Text(
                      '${DateFormat('hh:mm a').format(widget.entryTime!)} - ${DateFormat('hh:mm a').format(widget.exitTime!)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          backgroundColor: widget.entryTime == null
                              ? Theme.of(context).dividerColor
                              : null,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
