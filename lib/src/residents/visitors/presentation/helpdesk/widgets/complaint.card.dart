import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/widgets/app.snackbar.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/add.vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/reaction.type.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/get.complaint.votes.usecase%20copy.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/vote.complaint.usecase.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/page/comment.page.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/page/complaint.page.dart';

import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/network/api.dart';
import '../../../../../core/widgets/custom.shimmer.dart';
import '../page/edit.compliant.page.dart';

class ComplaintCard extends StatefulWidget {
  const ComplaintCard(
      {super.key, this.item, this.showDate = false, this.mine = false});
  final ComplaintEntity? item;
  final bool showDate;
  final bool mine;
  @override
  State<ComplaintCard> createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  bool reactions = false;
  bool loading = false;
  ComplaintEntity? complaint;
  List<VoteComplaintEntity> votes = [];
  int reactionsCount = 0;

  vote({required String type}) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    final vote = getIt<VoteComplaintUseCase>();
    final result = await vote(AddVoteComplaintParam(
        addVote: AddVoteComplaintEntity(
            type: type, entity_id: complaint?.nid ?? -1)));
    result?.fold((l) {
      setState(() {
        loading = false;
      });
      AppSnackBar.failure(failure: l);
    }, (r) async {
      updateReaction();
      await getMyVotes();
      updateReaction();
      if (mounted) {
        setState(() {
          loading = false;
          reactions = false;
          if (complaint != null && r.type != null) {
            complaint = ReactionType.getAdjustedComplaint(complaint!, r.type!);
          }
        });
      }
    });
  }

  getMyVotes() async {
    final myVotes = getIt<GetComplaintVotesUseCase>();
    final result =
        await myVotes(GetComplaintVotesParam(id: widget.item?.nid ?? -1));
    result?.fold((l) {}, (r) {
      if (mounted) {
        setState(() {
          votes = r;
        });
      }
    });
  }

  void updateReaction() {
    if (mounted) {
      setState(() {
        reactionsCount = 0;
        reactionsCount =
            reactionsCount + (((complaint?.vote_count_angry ?? 0) > 0) ? 1 : 0);
        reactionsCount = reactionsCount +
            (((complaint?.vote_count_laughing ?? 0) > 0) ? 1 : 0);
        reactionsCount =
            reactionsCount + (((complaint?.vote_count_like ?? 0) > 0) ? 1 : 0);
        reactionsCount =
            reactionsCount + (((complaint?.vote_count_sad ?? 0) > 0) ? 1 : 0);
        reactionsCount = reactionsCount +
            (((complaint?.vote_count_suprised ?? 0) > 0) ? 1 : 0);
        reactionsCount =
            reactionsCount + (((complaint?.vote_count_love ?? 0) > 0) ? 1 : 0);
      });
    }
  }

  @override
  void initState() {
    complaint = widget.item;
    getMyVotes();
    updateReaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (complaint != null && widget.showDate)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              child: Text(
                (DateFormat('yyyy-MM-dd')).format(complaint!.createdAt()),
                textAlign: TextAlign.left,
              ),
            ),
          InkWell(
            onTap: () {
              if (widget.mine &&
                  complaint?.nid != null &&
                  widget.item != null) {
                Get.to(() => EditComplaintPage(
                      item: widget.item!,
                    ))?.then((value) {
                  setState(() {
                    if (value != null &&
                        value.runtimeType == ComplaintEntity &&
                        (value as ComplaintEntity).nid != null) {
                      complaint = value;
                    }
                  });
                });
              } else if (complaint?.nid != null) {
                Get.to(() => ComplaintPage(
                      id: complaint!.nid!,
                    ));
              }
            },
            child: Material(
                elevation: 0.5,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (loading)
                        const Padding(
                          padding:
                              EdgeInsets.only(bottom: 20, left: 10, right: 10),
                          child: LoadingBar(),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          runSpacing: 10,
                          spacing: 10,
                          children: [
                            ..._images(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        (7 / 12),
                                    child: CustomShimmer(
                                      show: complaint == null,
                                      child: Text.rich(
                                        TextSpan(
                                            text: complaint?.title ??
                                                '...............................',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    backgroundColor:
                                                        complaint == null
                                                            ? Theme.of(context)
                                                                .highlightColor
                                                            : Colors
                                                                .transparent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                            children: []),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (complaint == null ||
                                          (complaint?.field_complaint_urgent ??
                                              false))
                                        CustomShimmer(
                                          show: complaint == null,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 6,
                                                bottom: 6),
                                            decoration: BoxDecoration(
                                                color:
                                                    Theme.of(context).cardColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20))),
                                            child: Text(
                                              'Urgent',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Colors.red,
                                                    backgroundColor:
                                                        complaint == null
                                                            ? Theme.of(context)
                                                                .highlightColor
                                                            : Colors
                                                                .transparent,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomShimmer(
                                        show: complaint == null,
                                        child: Text(
                                            complaint
                                                    ?.field_complaint_category ??
                                                '         ',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  backgroundColor:
                                                      complaint == null
                                                          ? Theme.of(context)
                                                              .highlightColor
                                                          : Colors.transparent,
                                                )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 30, left: 30, right: 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: CustomShimmer(
                                show: complaint == null,
                                child: Text(
                                  complaint?.body ??
                                      '...............................................................',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        backgroundColor: complaint == null
                                            ? Theme.of(context).highlightColor
                                            : Colors.transparent,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 10, right: 10, bottom: 20, top: 10),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [..._comments()],
                      //     )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _currentReactions(complaint),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => CommentPage(
                                      id: (complaint?.nid ?? 0).toString()));
                                },
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Theme.of(context)
                                                  .dividerColor,
                                              width: 1))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomShimmer(
                                        show: complaint == null,
                                        child: Icon(
                                          (Icons.comment_outlined),
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
                                        show: complaint == null,
                                        child: Text(
                                          (reactionsCount > 2)
                                              ? ''
                                              : ((complaint?.comment_count ??
                                                          0) ==
                                                      0
                                                  ? 'Comment'
                                                  : '${complaint?.comment_count ?? ''} Comments'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  backgroundColor:
                                                      complaint == null
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
                        ),
                      ),

                      if (reactions)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 10,
                            children: [
                              reactionItem(REACTION_TYPE.reaction_like),
                              reactionItem(REACTION_TYPE.reaction_love),
                              reactionItem(REACTION_TYPE.reaction_sad),
                              reactionItem(REACTION_TYPE.reaction_angry),
                              reactionItem(REACTION_TYPE.reaction_suprised)
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )),
          ),
        ]);
  }

  Widget reactionItem(REACTION_TYPE type) {
    return InkWell(
      onTap: () async => {await vote(type: ReactionType.getTypeText(type))},
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          margin: const EdgeInsets.symmetric(
            horizontal: 0,
          ),
          child: Column(
            children: [
              Text(
                ReactionType.getEmoji(type),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                ReactionType.getText(type),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          )),
    );
  }

  Widget _currentReactions(ComplaintEntity? item) {
    return InkWell(
      onTap: () {
        setState(() {
          reactions = !reactions;
        });
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
          right: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        )),
        child: (item == null)
            ? CustomShimmer(
                show: complaint == null,
                child: Icon(
                  Icons.favorite_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (reactionsCount == 0)
                    _reactionItem(REACTION_TYPE.reaction_like, count: 0),
                  if ((item.vote_count_angry ?? 0) > 0)
                    _reactionItem(REACTION_TYPE.reaction_angry,
                        count: item.vote_count_angry ?? 1),
                  if ((item.vote_count_like ?? 0) > 0)
                    _reactionItem(REACTION_TYPE.reaction_like,
                        count: item.vote_count_like ?? 1),
                  if ((item.vote_count_love ?? 0) > 0)
                    _reactionItem(REACTION_TYPE.reaction_love,
                        count: item.vote_count_love ?? 1),
                  if ((item.vote_count_sad ?? 0) > 0)
                    _reactionItem(REACTION_TYPE.reaction_sad,
                        count: item.vote_count_sad ?? 1),
                  if ((item.vote_count_laughing ?? 0) > 0)
                    _reactionItem(REACTION_TYPE.reaction_laughing,
                        count: item.vote_count_laughing ?? 1),
                  if ((item.vote_count_suprised ?? 0) > 0)
                    _reactionItem(REACTION_TYPE.reaction_suprised,
                        count: item.vote_count_suprised ?? 1)
                ],
              ),
      ),
    );
  }

  Widget _reactionItem(REACTION_TYPE type, {int count = 1}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: votes
                      .map((e) => e.type)
                      .contains(ReactionType.getTypeText(type))
                  ? 1
                  : 0),
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
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  List<Widget> _images() {
    if (complaint == null) {
      return [
        CustomShimmer(
          show: complaint == null,
          child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              )),
        )
      ];
    } else if (complaint?.field_image == null) {
      return [];
    }
    List<Widget> response = [];
    complaint?.field_image?.forEach((element) {
      response.add(Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('${Api.imageUrl()}$element'))),
      ));
    });
    return response;
  }
}
