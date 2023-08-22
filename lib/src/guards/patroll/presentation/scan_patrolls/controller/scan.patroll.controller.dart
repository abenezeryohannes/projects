import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/exceptions.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/widgets/app.snackbar.dart';
import 'package:rnginfra/src/guards/patroll/data/dtos/add.patroll.dto.dart';
import 'package:rnginfra/src/guards/patroll/domain/usecases/add.patroll.usecase.dart';

@injectable
class ScanPatrollController extends GetxController {
  final AddPatrollUseCase useCase;

  ScanPatrollController({required this.useCase});

  Rx<String> status = 'Scanning'.obs;

  Rx<Failure?> failure = Rx<Failure?>(null);

  RxBool canScan = true.obs;

  Future addQr(
      {required int qr_code,
      required double latitude,
      required double longitude}) async {
    //loading
    status.value = 'Uploading';
    status.refresh();
    //sending the request
    final result = await useCase(AddPatrollParam(
        patroll: AddPatrollDto(
            qr_code_id: qr_code, latitude: latitude, longitude: longitude)));
    //checking
    if (result == null) {
      //show error
      failure.value = UnExpectedFailure(message: UnExpectedException().message);
      failure.refresh();
      AppSnackBar.failure(failure: failure.value!);
      return;
    }
    result.fold((l) {
      failure.value = l;
      failure.refresh();
      AppSnackBar.failure(failure: l);
    }, (r) {
      canScan.value = false;
      canScan.refresh();
      status.value = 'Qr uploaded';
      Get.back();
      AppSnackBar.success(title: 'Success', message: "Reading Uploaded !!");
    });
  }
}
