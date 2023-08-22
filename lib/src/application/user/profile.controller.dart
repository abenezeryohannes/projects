import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/errors/exceptions.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/appcore/widgets/app.snackbar.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/domain/user/usecases/edit.user.usecase.dart';
import 'package:linko/src/domain/user/usecases/get.user.usecase.dart';
import 'package:linko/src/infrastructure/user/dtos/user.dto.dart';

@injectable
class ProfileController extends GetxController {
  final EditUserUsecase _editUserUsecase;
  final GetUserUsecase _findUserUsecase;

  ProfileController(this._findUserUsecase, this._editUserUsecase);

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  Rx<UserDto?> userDto = Rx<UserDto?>(null);
  RxBool loading = RxBool(false);
  Rx<Failure?> failure = Rx<Failure?>(null);
  RxString name = ''.obs;

  Future save({required UserDto userDto}) async {
    failure.value = null;
    failure.refresh();
    loading.value = true;

    final result =
        await _editUserUsecase(param: EditUserUsecaseParam(user: userDto));

    if (result == null) {
      loading.value = false;
      failure.value = UnExpectedFailure(message: UnExpectedException().message);
      AppSnackBar.failure(failure: failure.value!);
      refresh();
    } else {
      result.fold((l) {
        AppSnackBar.failure(failure: l);
        loading.value = false;
        failure.value = l;
        refresh();
      }, (r) {
        // AppSnackBar.success(
        //     title: 'update_successful'.tr, message: 'profile_updated'.tr);
        loading.value = false;
        if (r.data != null) {
          user.value = r.data;
        }
      });
    }
  }

  Future find({bool local = true}) async {
    failure.value = null;
    failure.refresh();
    loading.value = true;

    final result =
        await _findUserUsecase(param: GetUserUsecaseNoParam(local: local));

    if (result == null) {
      loading.value = false;
      failure.value = UnExpectedFailure(message: UnExpectedException().message);
      refresh();
    } else {
      result.fold((l) {
        loading.value = false;
        failure.value = l;
        refresh();
      }, (r) {
        if (r.data != null) {
          user.value = r.data;
          userDto.value = UserDto.fromEntity(r.data!);
          // name.value = user.value?.fullName ?? 'full_name';
        }
        loading.value = false;
      });
    }
  }
}
