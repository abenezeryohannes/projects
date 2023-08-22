import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/data/pagination.dto.dart';
import 'package:rnginfra/src/core/domain/entities/guest.activity.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/get.visitor.activities.usecase.dart';

import '../../../../../core/domain/entities/guest.visitation.entity.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

@injectable
class GetVisitorActivitiesController extends GetxController {
  final GetVisitorsActivitiesUseCase useCase;

  GetVisitorActivitiesController(this.useCase);
  RxString text = ''.obs;
  RxInt page = 0.obs;

  RxBool loading = RxBool(false);
  RxList<GuestVisitationEntity> visitations = RxList.empty();
  Rx<Pagination<GuestVisitationEntity>?> visitationWrapper =
      Rx<Pagination<GuestVisitationEntity>?>(null);
  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  static const pageSize = 25;

  final PagingController<int, GuestVisitationEntity?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future findAll(
      {int? id,
      int? limit,
      int page = 1,
      DateTime? startTime,
      DateTime? endTime}) async {
    final result = await useCase(GetVisitorsActivityParam(
        page: page, limit: limit, startTime: startTime, endTime: endTime));

    if (result == null) {
      pagingController.error = Failure(message: UnExpectedException().message);
    } else {
      result.fold((l) {
        pagingController.error = l;
      }, (r) {
        visitationWrapper.value = r;
        final isLastPage = (r.results?.length ?? 0) < (pageSize);
        if (isLastPage) {
          if (r.results != null) {
            pagingController.appendLastPage(
                r.results!.toList().cast<GuestVisitationEntity?>());
          }
        } else {
          if (r.results != null) {
            visitations.addAll(r.results!.where((element) => true));
            pagingController.appendPage(
                r.results!.cast<GuestVisitationEntity?>(), page + 1);
          }
          if (page == 1 && (r.results == null || r.results!.isEmpty)) {
            pagingController.notifyStatusListeners(PagingStatus.completed);
          }
        }
      });
    }
  }
}
