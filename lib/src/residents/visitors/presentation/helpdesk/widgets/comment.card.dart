import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/widgets/custom.shimmer.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/widgets/app.snackbar.dart';
import '../../../../../core/widgets/loading.bar.dart';
import '../../../domain/entities/add.vote.complaint.entity.dart';
import '../../../domain/entities/comment.entity.dart';
import '../../../domain/entities/reaction.type.dart';
import '../../../domain/entities/vote.complaint.entity.dart';
import '../../../domain/usecases/helpdesk/get.comment.votes.usecase.dart';
import '../../../domain/usecases/helpdesk/vote.complaint.usecase.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, this.comment});
  final CommentEntity? comment;
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool reactions = false;
  bool loading = false;
  CommentEntity? comment;
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
            type: type,
            entity_type: 'comment',
            entity_id: comment?.cid ?? -1)));
    result?.fold((l) {
      setState(() {
        loading = false;
      });
      AppSnackBar.failure(failure: l);
    }, (r) async {
      await getMyVotes();
      updateReaction();
      if (mounted) {
        setState(() {
          loading = false;
          reactions = false;
          if (comment != null && r.type != null) {
            comment = ReactionType.getAdjustedComment(comment!, r.type!);
          }
        });
      }
    });
  }

  getMyVotes() async {
    final myVotes = getIt<GetCommentVotesUseCase>();
    final result =
        await myVotes(GetCommentVotesParam(id: widget.comment?.cid ?? -1));
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
            reactionsCount + (((comment?.vote_count_angry ?? 0) > 0) ? 1 : 0);
        reactionsCount = reactionsCount +
            (((comment?.vote_count_laughing ?? 0) > 0) ? 1 : 0);
        reactionsCount =
            reactionsCount + (((comment?.vote_count_like ?? 0) > 0) ? 1 : 0);
        reactionsCount =
            reactionsCount + (((comment?.vote_count_sad ?? 0) > 0) ? 1 : 0);
        reactionsCount = reactionsCount +
            (((comment?.vote_count_suprised ?? 0) > 0) ? 1 : 0);
        reactionsCount =
            reactionsCount + (((comment?.vote_count_love ?? 0) > 0) ? 1 : 0);
      });
    }
  }

  @override
  void initState() {
    comment = widget.comment;
    getMyVotes();
    updateReaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8),
          child: InkWell(
            onTap: () {
              setState(() {
                reactions = !reactions;
              });
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (loading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                      child: LoadingBar(),
                    ),
                  if (widget.comment == null || widget.comment?.subject != null)
                    CustomShimmer(
                      show: widget.comment == null,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 4),
                        child: Text(
                          widget.comment?.subject ?? '........................',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  backgroundColor: widget.comment == null
                                      ? Theme.of(context).highlightColor
                                      : Colors.transparent),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: CustomShimmer(
                      show: widget.comment == null,
                      child: Text(
                        widget.comment?.comment_body ??
                            '.............................................................',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            backgroundColor: widget.comment == null
                                ? Theme.of(context).highlightColor
                                : Colors.transparent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  if (widget.comment == null || widget.comment?.changed != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomShimmer(
                          show: widget.comment == null,
                          child: Text(
                            widget.comment == null
                                ? '..............................'
                                : timeAgo.format(widget.comment!
                                    .changed!), // DateFormat('yyyy-MM-dd').format(widget.comment!.changed!),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    backgroundColor: widget.comment == null
                                        ? Theme.of(context).highlightColor
                                        : Colors.transparent),
                          ),
                        ),
                      ],
                    ),
                  _currentReactions(comment)
                ],
              ),
            ),
          ),
        ),
        if (reactions)
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 14),
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
      ],
    );
  }

  Widget _currentReactions(CommentEntity? item) {
    return InkWell(
      onTap: () {
        setState(() {
          reactions = !reactions;
        });
      },
      child: Container(
        height: reactionsCount == 0 ? 0 : 50,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 0),
          right: BorderSide(color: Theme.of(context).dividerColor, width: 0),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if ((item?.vote_count_angry ?? 0) > 0)
              _reactionItem(REACTION_TYPE.reaction_angry,
                  count: item?.vote_count_angry ?? 1),
            if ((item?.vote_count_like ?? 0) > 0)
              _reactionItem(REACTION_TYPE.reaction_like,
                  count: item?.vote_count_like ?? 1),
            if ((item?.vote_count_love ?? 0) > 0)
              _reactionItem(REACTION_TYPE.reaction_love,
                  count: item?.vote_count_love ?? 1),
            if ((item?.vote_count_sad ?? 0) > 0)
              _reactionItem(REACTION_TYPE.reaction_sad,
                  count: item?.vote_count_sad ?? 1),
            if ((item?.vote_count_laughing ?? 0) > 0)
              _reactionItem(REACTION_TYPE.reaction_laughing,
                  count: item?.vote_count_laughing ?? 1),
            if ((item?.vote_count_suprised ?? 0) > 0)
              _reactionItem(REACTION_TYPE.reaction_suprised,
                  count: item?.vote_count_suprised ?? 1)
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
          color: Theme.of(context)
              .colorScheme
              .secondary
              .withOpacity(count == 0 ? 0 : 0.1),
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
          if (count > 0)
            const SizedBox(
              height: 3,
            ),
          if (count > 0)
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
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
}
