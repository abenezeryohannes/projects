import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/get.complaint.categories.usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/get.complaints.usecase.dart';

import '../../../../../core/data/pagination.dto.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/app.snackbar.dart';
import '../../../domain/entities/category.entity.dart';
import '../../../domain/entities/complaint.entity.dart';

@injectable
class HelpDeskController extends GetxController {
  final GetComplaintsUseCase _getComplaintsUseCase;
  final GetComplaintCategoriesUseCase _getComplaintCategoriesUseCase;

  HelpDeskController(
      this._getComplaintCategoriesUseCase, this._getComplaintsUseCase);

  final PagingController<int, ComplaintEntity?> pagingController =
      PagingController(firstPageKey: 1);

  Rx<List<CategoryEntity>> categories = Rx<List<CategoryEntity>>([]);
  RxList<ComplaintEntity> complaints = RxList<ComplaintEntity>([]);
  RxString search = ''.obs;
  CategoryEntity? selectedCategory = null;

  Rx<Pagination<ComplaintEntity?>?> complaintsPagination =
      Rx<Pagination<ComplaintEntity?>?>(null);

  Future find({String? search, int limit = 25, int page = 1}) async {
    final result = await _getComplaintsUseCase(GetComplaintsParam(
        search: search ?? this.search.value,
        page: page,
        limit: limit,
        categoryID: selectedCategory?.tid));

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

  Future findCategories({String? search, int? limit, int page = 1}) async {
    final result = await _getComplaintCategoriesUseCase(
        GetComplaintCategoriesParam(search: search, page: page, limit: limit));

    if (result == null) {
      AppSnackBar.warning(
          title: 'Error loading categories',
          message: UnExpectedException().message);
      return;
    } else {
      result.fold((l) {
        AppSnackBar.warning(
            title: 'Error loading categories', message: l.message);
      }, (r) {
        // final isLastPage = (r.results.length) < (limit ?? 0);
        // if (isLastPage) {
        categories.value.addAll(r.results);
        categories.refresh();
        // }
      });
    }
  }
}
