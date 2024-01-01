import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/vote.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/get.complaints.vote.usecase.dart';

import '../../../../../core/data/pagination.dto.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

@injectable
class MyReactionController extends GetxController {
  final GetComplaintsVoteUseCase _getVotes;

  MyReactionController(this._getVotes);

  Rx<Pagination<VoteComplaintEntity?>?> votesPagination =
      Rx<Pagination<VoteComplaintEntity?>?>(null);

  final PagingController<int, VoteComplaintEntity?> pagingController =
      PagingController(firstPageKey: 1);

  RxList<VoteComplaintEntity> votes = RxList<VoteComplaintEntity>([]);

  Future find({String? search, int limit = 25, int page = 1}) async {
    final result =
        await _getVotes(GetComplaintsVoteParam(page: page, limit: limit));

    if (result == null) {
      pagingController.error = Failure(message: UnExpectedException().message);
    } else {
      result.fold((l) {
        pagingController.error = l;
      }, (r) {
        votes.value = r;
        if (r.isNotEmpty) {
          pagingController
              .appendLastPage(r.toList().cast<VoteComplaintEntity?>());
        } else {
          pagingController.appendLastPage([]);
          pagingController.error = NoDataException();
        }
      });
    }
  }
}
