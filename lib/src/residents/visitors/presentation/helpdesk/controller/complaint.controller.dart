import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/create.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/edit.complaint.usecase.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/app.snackbar.dart';
import '../../../domain/usecases/helpdesk/get.complaint.usecase.dart';

@injectable
class ComplaintController extends GetxController {
  final GetComplaintUseCase _getComplaintUseCase;
  final EditComplaintUseCase _editComplaintUseCase;

  ComplaintController(this._getComplaintUseCase, this._editComplaintUseCase);

  Rx<ComplaintEntity?> complaint = Rx<ComplaintEntity?>(null);
  Rx<CreateComplaintEntity?> eComplaint = Rx<CreateComplaintEntity?>(null);

  RxBool loading = false.obs;

  Rx<Failure?> failure = Rx<Failure?>(null);

  Future find({
    required String id,
  }) async {
    final result = await _getComplaintUseCase(GetComplaintParam(id: id));

    if (result == null) {
      AppSnackBar.warning(
          title: 'Error loading the complaint',
          message: UnExpectedException().message);
    } else {
      result.fold((l) {
        failure.value = l;
        failure.refresh();
        AppSnackBar.warning(
            title: 'Error loading complaint', message: l.message);
      }, (r) {
        complaint.value = r;
        eComplaint.value?.fromEntity(complaint.value);
        complaint.refresh();
      });
    }
  }

  Future<bool> editComplaint(
      {required Function(ComplaintEntity) onSuccess,
      required String id,
      required CreateComplaintEntity complaint}) async {
    loading.value = true;
    loading.refresh();
    final result = await _editComplaintUseCase(
        EditComplaintParam(id: id, complaint: complaint));

    if (result == null) {
      AppSnackBar.warning(
          title: 'Error loading complaint',
          message: UnExpectedException().message);
      return false;
    } else {
      result.fold((l) {
        AppSnackBar.warning(
            title: 'Error loading complaint', message: l.message);
      }, (r) {
        onSuccess(r);
      });
    }
    loading.value = false;
    loading.refresh();
    if (result.isRight()) return true;
    return false;
  }
}
