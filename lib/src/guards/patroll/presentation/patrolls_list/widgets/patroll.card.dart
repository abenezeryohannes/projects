import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/widgets/custom.shimmer.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class PatrollCard extends StatefulWidget {
  const PatrollCard({super.key, this.patroll, this.showDate = false});
  final PatrollEntity? patroll;
  final bool showDate;
  @override
  State<PatrollCard> createState() => _PatrollCardState();
}

class _PatrollCardState extends State<PatrollCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.patroll != null && widget.showDate)
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 20),
            child: Text(
              (DateFormat('yyyy-MM-dd')).format(widget.patroll!.created),
              textAlign: TextAlign.left,
            ),
          ),
        Material(
          elevation: 0.3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            padding:
                const EdgeInsets.only(left: 8, right: 20, bottom: 5, top: 5),
            child: Row(
              children: [
                CustomShimmer(
                  show: widget.patroll == null,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Random().nextInt(2) + 1 == 1
                            ? Colors.amber.shade800
                            : Theme.of(context).colorScheme.secondary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: const Icon(
                      Icons.qr_code,
                      color: Colors.white,
                      size: 42,
                    ),
                    // child: Image.asset(
                    //   'assets/icon/qr.png',
                    //   width: 32,
                    //   height: 32,
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        CustomShimmer(
                          show: widget.patroll == null,
                          child: Text(
                            widget.patroll?.title ?? '.....................',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: (widget.patroll != null)
                                        ? null
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        CustomShimmer(
                          show: widget.patroll == null,
                          child: Text(
                            widget.patroll?.title ??
                                '.............,....................................',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 14,
                                    backgroundColor: (widget.patroll != null)
                                        ? null
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomShimmer(
                          show: widget.patroll == null,
                          child: Text(
                            widget.patroll != null
                                ? (widget.patroll!.created
                                            .difference(DateTime.now())
                                            .inDays !=
                                        0
                                    ? (DateFormat.yMMMMEEEEd()
                                        .format(widget.patroll!.created))
                                    : timeago.format(
                                        widget.patroll!.created,
                                      ))
                                : '...................',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 12,
                                    backgroundColor: (widget.patroll != null)
                                        ? null
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
