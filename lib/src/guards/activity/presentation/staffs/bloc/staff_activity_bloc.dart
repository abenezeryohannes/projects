import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/get.staffs.activities.usecase.dart';

import '../../../../../core/data/pagination.dto.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/activity.entity.dart';
import '../../../domain/entities/staff.attendance.entity.dart';

part 'staff_activity_event.dart';
part 'staff_activity_state.dart';

@injectable
class StaffActivityBloc extends Bloc<StaffActivityEvent, StaffActivityState> {
  final GetStaffsActivityUseCase _getStaffsActivityUseCase;
  final Pagination<StaffAttendanceEntity> activities =
      Pagination<StaffAttendanceEntity>.fill();
  final int pageLimit = 25;
  DateTime? selectedDay;

  final PagingController<int, StaffAttendanceEntity?> pagingController =
      PagingController(firstPageKey: 0);

  StaffActivityBloc(this._getStaffsActivityUseCase)
      : super(StaffActivityInitial()) {
    on<StaffActivityEvent>((event, emit) {});

    on<OnLoadStaffAttendanceEvent>((event, emit) async {
      final result = await _getStaffsActivityUseCase(GetStaffsActivityParam(
          page: event.page,
          limit: event.limit,
          startTime: event.startTime,
          type: event.type,
          endTime: event.endTime));
      if (result == null) {
        pagingController.error = Failure(message: UnExpectedFailure().message);
      }
      result?.fold((l) {
        pagingController.error = l;
        emit(ErrorLoadingStaffActivityState(failure: l));
      }, (r) async {
        if (r.results.isEmpty) {
          pagingController.error =
              NoDataFailure(message: NoDataException().message);
          emit(ErrorLoadingStaffActivityState(
              failure: NoDataFailure(message: NoDataException().message)));
          return;
        }
        final isLastPage = r.results.length < r.pager.items_per_page ||
            r.pager.pages == r.pager.current_page + 1;
        if ((event.page ?? 0) == 0 && pagingController.itemList != null) {
          pagingController.itemList!.clear();
        }
        if (isLastPage) {
          pagingController.appendLastPage(r.results);
        } else {
          final nextPageKey = (event.page ?? 1) + 1;
          pagingController.appendPage(r.results, nextPageKey);
        }
        // emit(LoadedPatrollState(patrolls: patrolls));
      });
    });
  }
}
