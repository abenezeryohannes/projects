import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/usecases/edit.staff.attendance.usecase.dart';

@injectable
class EditStaffAttendanceController extends GetxController {
  final EditStaffAttendanceUseCase editStaffAttendanceUseCase;

  EditStaffAttendanceController({required this.editStaffAttendanceUseCase});

  // loading status holder variables
  RxBool loadingEditStaffs = false.obs;
  Rx<DateTime?> exitTime = Rx<DateTime?>(null);
  Rx<DateTime?> entranceTime = Rx<DateTime?>(null);

  //data holder
  Rx<StaffActivityEntity?> staffActivity = Rx<StaffActivityEntity?>(null);
  Rx<List<UserEntity>> staffUsers = Rx<List<UserEntity>>([]);

  //error holder variable

  Rx<Failure?> staffActivityError = Rx<Failure?>(null);

  //adding
  Future editStaffActivity(
      {required String targetId,
      DateTime? entranceTime,
      DateTime? exitTime}) async {
    loadingEditStaffs.value = true;
    loadingEditStaffs.refresh();
    staffActivityError.value = null;
    staffActivityError.refresh();

    final result = await editStaffAttendanceUseCase(EditStaffAttendanceParam(
        targetId: targetId, exitTime: exitTime, entranceTime: entranceTime));
    if (result == null) {
      staffActivityError.value = Failure(message: UnExpectedFailure().message);
      loadingEditStaffs.value = false;
      loadingEditStaffs.refresh();
      staffActivityError.refresh();
    }
    result?.fold((l) {
      staffActivityError.value = l;
      loadingEditStaffs.value = false;
      loadingEditStaffs.refresh();
      staffActivityError.refresh();
    }, (r) async {
      staffActivityError.value = null;
      staffActivityError.refresh();
      staffActivity.value = r;
      staffActivity.refresh();
      loadingEditStaffs.value = false;
      loadingEditStaffs.refresh();
    });
  }
}
