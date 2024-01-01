import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/widgets/custom.shimmer.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';

import '../../../domain/entities/reaction.type.dart';

class ReactionCard extends StatefulWidget {
  const ReactionCard({super.key, this.vote, this.showDate = false});
  final VoteComplaintEntity? vote;
  final bool showDate;
  @override
  State<ReactionCard> createState() => _ReactionCardState();
}

class _ReactionCardState extends State<ReactionCard> {
//
  VoteComplaintEntity? vote;
//
  @override
  void initState() {
    vote = widget.vote;
    super.initState();
  }

//
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (vote != null && widget.showDate)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              child: Text(
                (DateFormat('yyyy-MM-dd')).format(vote!.timestamp!),
                textAlign: TextAlign.left,
              ),
            ),
          Material(
              elevation: 0.5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 10),
                      child: Row(
                        children: [
                          CustomShimmer(
                            show: widget.vote == null,
                            child: _reactionItem(
                                ReactionType.getTypeFromText(vote?.type ?? ''),
                                context),
                          ),
                          // Text(
                          //   vote?.title ?? '',
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .bodyMedium!
                          //       .copyWith(fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 14, right: 10, bottom: 8),
                      child: CustomShimmer(
                        show: widget.vote == null,
                        child: Text(
                          vote?.title ?? '........................',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: (widget.vote?.title != null)
                                      ? Colors.transparent
                                      : Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14, right: 10, bottom: 14),
                      child: CustomShimmer(
                          show: widget.vote == null,
                          child: Text(
                            vote?.body ??
                                '..............................................',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    backgroundColor:
                                        (widget.vote?.title != null)
                                            ? Colors.transparent
                                            : Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                          )),
                    ),
                  ],
                ),
              )),
        ]);
  }
//
//
//

  Widget _reactionItem(REACTION_TYPE type, BuildContext context,
      {int count = 1}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary, width: 1),
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ReactionType.getEmoji(type),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 3,
          ),
          // Text(
          //   count.toString(),
          //   style: Theme.of(context).textTheme.bodySmall,
          // ),
        ],
      ),
    );
  }
}
