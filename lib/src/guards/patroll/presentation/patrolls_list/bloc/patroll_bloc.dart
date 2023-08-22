import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/exceptions.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/add.patroll.usecase.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/delete.patroll.usecase.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/edit.patroll.usecase.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/list.patroll.usecase.dart';

import '../../../domain/entitites/patroll.entity.dart';

part 'patroll_event.dart';
part 'patroll_state.dart';

@injectable
class PatrollBloc extends Bloc<PatrollEvent, PatrollState> {
  final AddPatrollUseCase _addPatrollUseCase;
  final EditPatrollUseCase _editPatrollUseCase;
  final DeletePatrollUseCase _deletePatrollUseCase;
  final ListPatrollUseCase _listPatrollUseCase;
  final List<PatrollEntity> patrolls = [];
  final int pageLimit = 25;
  DateTime? selectedDay;

  final PagingController<int, PatrollEntity?> pagingController =
      PagingController(firstPageKey: 0);

  PatrollBloc(this._addPatrollUseCase, this._editPatrollUseCase,
      this._listPatrollUseCase, this._deletePatrollUseCase)
      : super(InitialPatrollState()) {
    //initial
    on<OnInitialPatrollEvent>((event, emit) {
      add(OnLoadPatrollEvent(page: 0, limit: pageLimit));
    });
    // //load
    // on<OnLoadPatrollEvent>((event, emit) async {
    //   emit(LoadingPatrollState());
    //   final result = await _listPatrollUseCase(ListPatrollParam(
    //       page: event.page,
    //       limit: event.limit,
    //       startTime: event.startTime,
    //       endTime: event.endTime));
    //   if (result == null) {
    //     emit(ErrorLoadingPatrollState(
    //         failure: Failure(message: UnExpectedFailure().message)));
    //   }
    //   result?.fold((l) {
    //     emit(ErrorLoadingPatrollState(failure: l));
    //   }, (r) async {
    //     if (r.isEmpty) {
    //       emit(ErrorLoadingPatrollState(
    //           failure: NoDataFailure(message: NoDataException().message)));
    //       return;
    //     }
    //     if ((event.page ?? 0) <= 1) {
    //       patrolls.clear();
    //     }
    //     patrolls.addAll(r);
    //     emit(LoadedPatrollState(patrolls: patrolls));
    //   });
    // });

    //load
    on<OnLoadPatrollEvent>((event, emit) async {
      final result = await _listPatrollUseCase(ListPatrollParam(
          page: event.page,
          limit: event.limit,
          startTime: event.startTime,
          endTime: event.endTime));
      if (result == null) {
        pagingController.error = Failure(message: UnExpectedFailure().message);
      }
      result?.fold((l) {
        pagingController.error = l;
        emit(ErrorLoadingPatrollState(failure: l));
      }, (r) async {
        if (r.results.isEmpty) {
          pagingController.error =
              NoDataFailure(message: NoDataException().message);
          emit(ErrorLoadingPatrollState(
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

    //add
    // on<OnAddPatrollEvent>((event, emit) async {
    //   emit(AddingPatrollState());
    //   final result =
    //       await _addPatrollUseCase(AddPatrollParam(patroll: event.patroll));
    //   if (result == null) {
    //     emit(ErrorLoadingPatrollState(
    //         failure: Failure(message: UnExpectedFailure().message)));
    //   }
    //   result?.fold((l) {
    //     emit(ErrorAddingPatrollState(failure: l));
    //   }, (r) async {
    //     emit(AddedPatrollState(patroll: r));
    //   });
    // });
    //delete
    on<OnDeletPatrollEvent>((event, emit) async {
      emit(DeletingPatrollState());
      final result = await _deletePatrollUseCase(
          DeletePatrollParam(patroll: event.patroll));
      if (result == null) {
        emit(ErrorDeletingPatrollState(
            failure: Failure(message: UnExpectedFailure().message)));
      }
      result?.fold((l) {
        emit(ErrorDeletingPatrollState(failure: l));
      }, (r) async {
        emit(DeletedPatrollState());
      });
    });
    //edit
    on<OnEditPatrollEvent>((event, emit) async {
      emit(EditingPatrollState());
      final result = await _editPatrollUseCase(
          EditPatrollParam(event.id, patroll: event.patroll));
      if (result == null) {
        emit(ErrorEditingPatrollState(
            failure: Failure(message: UnExpectedFailure().message)));
      }
      result?.fold((l) {
        emit(ErrorEditingPatrollState(failure: l));
      }, (r) async {
        emit(EditedPatrollState(patroll: r));
      });
    });
  }
}
