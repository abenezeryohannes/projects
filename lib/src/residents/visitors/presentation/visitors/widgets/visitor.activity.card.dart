import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/domain/entities/guest.visitation.entity.dart';
import '../../../../../core/domain/entities/visitation.entity.dart';
import '../../../../../core/widgets/custom.shimmer.dart';
import '../../../../../core/domain/entities/guest.activity.types.dart';
import '../pages/visitor.added.dialog.dart';

class VisitorActivityCard extends StatefulWidget {
  const VisitorActivityCard({super.key, this.visitation, this.showDate = true});
  final GuestVisitationEntity? visitation;
  final bool showDate;

  @override
  State<VisitorActivityCard> createState() => _VisitorActivityCardState();
}

class _VisitorActivityCardState extends State<VisitorActivityCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String? uuid = widget.visitation?.uuid ?? '';
        Get.dialog(
            VisitorAddedDialog(visitation: VisitationEntity(uuid: uuid)));
      },
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.visitation != null && widget.showDate)
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 20),
                child: Text(
                  (DateFormat('yyyy-MM-dd'))
                      .format(widget.visitation!.createdAt()),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                show: widget.visitation == null,
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(int.parse(
                                              GuestActivityTypes.getType(widget
                                                              .visitation
                                                              ?.guest_type ??
                                                          '')
                                                      ?.color ??
                                                  '0xFF444336'))),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(1000))),
                                  child: Image.asset(
                                    GuestActivityTypes.getType(
                                                widget.visitation?.guest_type ??
                                                    '')
                                            ?.icon ??
                                        'assets/img/user_account.png',
                                    width: 24,
                                    height: 24,
                                    color: Color(int.parse(
                                        GuestActivityTypes.getType(widget
                                                        .visitation
                                                        ?.guest_type ??
                                                    '')
                                                ?.color ??
                                            '0xFF444336')),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomShimmer(
                                        show: widget.visitation == null,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              (8 / 12),
                                          child: Text.rich(
                                            TextSpan(
                                                text: GuestActivityTypes
                                                            .getType(widget
                                                                    .visitation
                                                                    ?.guest_type ??
                                                                '')
                                                        ?.name ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        // overflow: TextOverflow.ellipsis,
                                                        backgroundColor:
                                                            widget.visitation ==
                                                                    null
                                                                ? Theme.of(
                                                                        context)
                                                                    .hintColor
                                                                : null),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        ' ( ${widget.visitation?.residents ?? 'Unknown'} ) ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            // overflow:
                                                            //     TextOverflow.ellipsis,
                                                            backgroundColor: widget
                                                                        .visitation ==
                                                                    null
                                                                ? Theme.of(
                                                                        context)
                                                                    .hintColor
                                                                : null),
                                                  )
                                                ]),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 3),
                                    child: CustomShimmer(
                                      show: widget.visitation?.short_notes ==
                                          null,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (8 / 12),
                                        child: Text(
                                          widget.visitation?.short_notes ??
                                              '...............',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: false,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  backgroundColor: widget
                                                              .visitation
                                                              ?.short_notes ==
                                                          null
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onBackground
                                                      : Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 3),
                                    child: CustomShimmer(
                                      show:
                                          widget.visitation?.long_notes == null,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (8 / 12),
                                        child: Text(
                                          widget.visitation?.long_notes ??
                                              '................................',
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 5,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  backgroundColor: widget
                                                              .visitation
                                                              ?.short_notes ==
                                                          null
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onBackground
                                                      : Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // EntryAndExitTime(
                                  //     entryTime: widget.activity?.entryAt(),
                                  //     exitTime: widget.activity?.exitAt())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ]),
    );
  }
}
