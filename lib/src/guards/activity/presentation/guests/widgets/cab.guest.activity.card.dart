import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/widgets/entry.and.exit.time.dart';

import '../../../../../core/domain/entities/guest.visitation.entity.dart';
import '../../../../../core/network/api.dart';
import '../../../../../core/widgets/custom.shimmer.dart';
import '../../../../../core/domain/entities/guest.activity.types.dart';

class CabGuestActivityCard extends StatefulWidget {
  const CabGuestActivityCard({super.key, this.activity, this.showDate = true});
  final GuestVisitationEntity? activity;
  final bool showDate;

  @override
  State<CabGuestActivityCard> createState() => _CabGuestActivityCardState();
}

class _CabGuestActivityCardState extends State<CabGuestActivityCard> {
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
                (DateFormat('yyyy-MM-dd')).format(widget.activity!.createdAt()),
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
                              child: (widget.activity?.guest_image != null &&
                                      widget.activity!.guest_image!
                                          .trim()
                                          .isNotEmpty)
                                  ? CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      radius: 16,
                                      backgroundImage: NetworkImage(
                                          '${Api.imageUrl()}${widget.activity!.guest_image!}'))
                                  : Container(
                                      padding: const EdgeInsets.all(5.0),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(int.parse(
                                                  GuestActivityTypes.getType(widget
                                                                  .activity
                                                                  ?.guest_type ??
                                                              '')
                                                          ?.color ??
                                                      '0xFF444336'))),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(1000))),
                                      child: Image.asset(
                                        GuestActivityTypes.getType(widget
                                                        .activity?.guest_type ??
                                                    '')
                                                ?.icon ??
                                            'assets/img/user_account.png',
                                        width: 24,
                                        height: 24,
                                        color: Color(int.parse(
                                            GuestActivityTypes.getType(widget
                                                            .activity
                                                            ?.guest_type ??
                                                        '')
                                                    ?.color ??
                                                '0xFF444336')),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomShimmer(
                                  show: widget.activity == null,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        (8 / 12),
                                    child: Text.rich(
                                      TextSpan(
                                          text: GuestActivityTypes.getType(
                                                      widget.activity
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
                                                      widget.activity == null
                                                          ? Theme.of(context)
                                                              .hintColor
                                                          : null),
                                          children: [
                                            TextSpan(
                                              text:
                                                  ' ( ${widget.activity?.residents ?? 'Unknown'} ) ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      // overflow:
                                                      //     TextOverflow.ellipsis,
                                                      backgroundColor: widget
                                                                  .activity ==
                                                              null
                                                          ? Theme.of(context)
                                                              .hintColor
                                                          : null),
                                            )
                                          ]),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10.0, left: 3),
                                  child: CustomShimmer(
                                    show: widget.activity?.short_notes == null,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          (8 / 12),
                                      child: Text(
                                        widget.activity?.short_notes ??
                                            '...............',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                backgroundColor:
                                                    widget.activity
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
                                  padding:
                                      const EdgeInsets.only(top: 10.0, left: 3),
                                  child: CustomShimmer(
                                    show: widget.activity?.long_notes == null,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          (8 / 12),
                                      child: Text(
                                        widget.activity?.long_notes ??
                                            '................................',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 5,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                backgroundColor:
                                                    widget.activity
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
                                EntryAndExitTime(
                                    entryTime: widget.activity?.entryAt(),
                                    exitTime: widget.activity?.exitAt())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //more inco

                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       CustomShimmer(
                    //         show: widget.activity == null,
                    //         child: const CircleAvatar(
                    //             radius: 14,
                    //             backgroundImage:
                    //                 AssetImage('assets/img/user_account.png')),
                    //       ),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       CustomShimmer(
                    //         show: widget.activity == null,
                    //         child: Text(
                    //           widget.activity?.residents ?? 'Unknown',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .titleSmall!
                    //               .copyWith(
                    //                   backgroundColor: widget.activity == null
                    //                       ? Theme.of(context).hintColor
                    //                       : null),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       CustomShimmer(
                    //         show: widget.activity == null,
                    //         child: const CircleAvatar(
                    //             radius: 14,
                    //             backgroundImage:
                    //                 AssetImage('assets/img/user_account.png')),
                    //       ),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       // CustomShimmer(
                    //       //   show: widget.activity == null,
                    //       //   child: Text(
                    //       //     '${(widget.activity?.Approval?.status ?? -1) == 1 ? 'Allowed By' : ((widget.activity?.Approval?.status ?? -1) == -1 ? 'Rejected By' : 'Waiting Approval From ')} Sasanka',
                    //       //     style: Theme.of(context)
                    //       //         .textTheme
                    //       //         .titleSmall!
                    //       //         .copyWith(
                    //       //             backgroundColor: widget.activity == null
                    //       //                 ? Theme.of(context).hintColor
                    //       //                 : null,
                    //       //             color: Theme.of(context).hintColor),
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),

                    //
                    // Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {},
                    //       child: Container(
                    //         height: 50,
                    //         padding: const EdgeInsets.symmetric(horizontal: 40),
                    //         decoration: BoxDecoration(
                    //             border: Border(
                    //           top: BorderSide(
                    //               color: Theme.of(context).dividerColor,
                    //               width: 1),
                    //           right: BorderSide(
                    //               color: Theme.of(context).dividerColor,
                    //               width: 1),
                    //         )),
                    //         child: CustomShimmer(
                    //           show: widget.activity == null,
                    //           child: Icon(
                    //             Icons.phone,
                    //             color: Theme.of(context).colorScheme.secondary,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    // Expanded(
                    //   child: InkWell(
                    //     onTap: () {},
                    //     child: Container(
                    //       height: 50,
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 30, vertical: 10),
                    //       decoration: BoxDecoration(
                    //           border: Border(
                    //               top: BorderSide(
                    //                   color: Theme.of(context).dividerColor,
                    //                   width: 1))),
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           CustomShimmer(
                    //             show: widget.activity == null,
                    //             child: Icon(
                    //               (widget.activity?.Approval?.status ??
                    //                           -1) ==
                    //                       1
                    //                   ? Icons.check
                    //                   : ((widget.activity?.Approval
                    //                                   ?.status ??
                    //                               -1) ==
                    //                           -1
                    //                       ? Icons.block
                    //                       : Icons.pending_actions_outlined),
                    //               size: 20,
                    //               color: Theme.of(context)
                    //                   .colorScheme
                    //                   .secondary,
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 10,
                    //           ),
                    //           CustomShimmer(
                    //             show: widget.activity == null,
                    //             child: Text(
                    //               (widget.activity?.Approval?.status ??
                    //                           -1) ==
                    //                       1
                    //                   ? 'Approved'
                    //                   : ((widget.activity?.Approval
                    //                                   ?.status ??
                    //                               -1) ==
                    //                           -1
                    //                       ? 'Wrong entry'
                    //                       : 'Waiting Approval'),
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .bodyMedium!
                    //                   .copyWith(
                    //                       backgroundColor:
                    //                           widget.activity == null
                    //                               ? Theme.of(context)
                    //                                   .hintColor
                    //                               : null),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                    // ],
                    // )
                  ],
                ),
              ))
        ]);
  }
}
