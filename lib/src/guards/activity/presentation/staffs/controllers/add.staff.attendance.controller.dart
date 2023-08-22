import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/add.staff.attendance.usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/get.staffs.usecase.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/pages/guard.staff.attendance.page.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/app.snackbar.dart';

@injectable
class AddStaffAttendanceController extends GetxController {
  final AddStaffAttendanceUseCase addStaffAttendanceUseCase;
  final GetStaffsUseCase getStaffsUseCase;
  final Rx<UserEntity?> staffSelected = Rx<UserEntity?>(null);

  AddStaffAttendanceController(
      {required this.addStaffAttendanceUseCase,
      required this.getStaffsUseCase});

  // loading status holder variables
  RxBool loadingAddStaffs = false.obs;
  RxBool loadingStaffs = false.obs;

  //data holder
  Rx<StaffActivityEntity?> staffActivity = Rx<StaffActivityEntity?>(null);
  Rx<List<UserEntity>> staffUsers = Rx<List<UserEntity>>([]);

  //error holder variable

  Rx<Failure?> staffActivityError = Rx<Failure?>(null);

  //adding
  Future addStaffActivity(
      {required String targetId, required DateTime time}) async {
    loadingAddStaffs.value = true;
    loadingAddStaffs.refresh();

    final result = await addStaffAttendanceUseCase(
        AddStaffAttendanceParam(targetId: targetId, time: time));
    if (result == null) {
      staffActivityError.value = Failure(message: UnExpectedFailure().message);
      loadingAddStaffs.value = false;
      loadingAddStaffs.refresh();
      staffActivityError.refresh();
    }
    result?.fold((l) {
      staffActivityError.value = l;
      loadingAddStaffs.value = false;
      loadingAddStaffs.refresh();
      staffActivityError.refresh();
    }, (r) async {
      staffActivityError.value = null;
      staffActivityError.refresh();
      staffActivity.value = r;
      staffActivity.refresh();
      loadingAddStaffs.value = false;
      loadingAddStaffs.refresh();
    });
  }

  //adding without UI update

  Future addStaffSnack(
      {required String targetId,
      required DateTime time,
      GuardStaffAttendancePage? page}) async {
    final result = await addStaffAttendanceUseCase(
        AddStaffAttendanceParam(targetId: targetId, time: time));
    if (result == null) {
      AppSnackBar.failure(
          failure: Failure(message: UnExpectedFailure().message.toString()));
    }
    result?.fold((l) {
      AppSnackBar.failure(failure: Failure(message: l.message.toString()));
    }, (r) async {
      AppSnackBar.success(
          title: 'Successful', message: 'Attendance Saved Succesfully');
      if (page != null) page.reload();
    });
  }

  //getting
  Future getStaffs(
      {required String search, required int? limit, required int? page}) async {
    loadingStaffs.value = true;
    loadingStaffs.refresh();

    final result = await getStaffsUseCase(
        GetStaffsParam(limit: 25, search: search, page: page));
    if (result == null) {
      staffActivityError.value = Failure(message: UnExpectedFailure().message);
      loadingStaffs.value = false;
      loadingStaffs.refresh();
      staffActivityError.refresh();
    }
    result?.fold((l) {
      staffUsers.value = [];
      staffUsers.refresh();
    }, (r) async {
      staffUsers.value = r.results;
      staffUsers.refresh();
    });
  }
}
