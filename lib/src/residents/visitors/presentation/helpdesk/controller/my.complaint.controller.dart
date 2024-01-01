import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/get.my.complaint.usecase.dart';

import '../../../../../core/data/pagination.dto.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/complaint.entity.dart';

@injectable
class MyComplaintController extends GetxController {
  final GetMyComplaintsUseCase _getComplaintsUseCase;

  MyComplaintController(this._getComplaintsUseCase);

  final PagingController<int, ComplaintEntity?> pagingController =
      PagingController(firstPageKey: 1);

  RxList<ComplaintEntity> complaints = RxList<ComplaintEntity>([]);

  Rx<Pagination<ComplaintEntity?>?> complaintsPagination =
      Rx<Pagination<ComplaintEntity?>?>(null);

  Future find({String? search, int limit = 25, int page = 1}) async {
    final result = await _getComplaintsUseCase(
        GetMyComplaintsParam(page: page, limit: limit));

    if (result == null) {
      pagingController.error = Failure(message: UnExpectedException().message);
    } else {
      result.fold((l) {
        pagingController.error = l;
      }, (r) {
        complaintsPagination.value = r;
        final isLastPage = (r.results?.length ?? 0) < (limit);
        if (isLastPage) {
          if (r.results != null) {
            pagingController
                .appendLastPage(r.results!.toList().cast<ComplaintEntity?>());
          }
        } else {
          if (r.results != null) {
            complaints.addAll(r.results!.where((element) => true));
            pagingController.appendPage(
                r.results!.cast<ComplaintEntity?>(), page + 1);
          }
          if (page == 1 && (r.results == null || r.results!.isEmpty)) {
            pagingController.notifyStatusListeners(PagingStatus.completed);
          }
        }
      });
    }
  }
}
