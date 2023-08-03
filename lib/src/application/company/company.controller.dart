import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/widgets/app.snackbar.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';
import 'package:linko/src/domain/company/usecases/add.company.usecase.dart';
import 'package:linko/src/domain/company/usecases/find.tag.usecase.dart';
import 'package:linko/src/domain/user/usecases/get.user.usecase.dart';
import 'package:linko/src/infrastructure/company/dto/company.dto.dart';
import 'package:linko/src/infrastructure/company/dto/tag.dto.dart';

import '../../appcore/errors/exceptions.dart';
import '../../appcore/errors/failure.dart';
import '../../domain/user/entities/user.entity.dart';
import '../../presentation/company/on.business.add.modal.dart';

@injectable
class CompanyController extends GetxController {
  final AddCompanyUsecase _add;
  final GetUserUsecase _getUser;
  final FindTagUsecase _findTag;

  // Rx<CompanyEntity?> company = Rx<CompanyEntity?>(null);
  Rx<CompanyDto> dto = Rx<CompanyDto>(CompanyDto(name: '', userId: -1));
  RxList<TagDto> tagsDto = RxList<TagDto>();
  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  Rx<Failure?> failure = Rx<Failure?>(null);
  RxBool loading = RxBool(false);
  RxList<TagEntity> tags = RxList<TagEntity>();

  CompanyController(this._add, this._getUser, this._findTag);

  Future save(
      {required CompanyDto companyDto, required BuildContext context}) async {
    failure.value = null;
    failure.refresh();
    loading.value = true;
    companyDto.tags = tagsDto.map((e) => e.name).toList();

    final result =
        await _add(param: AddCompanyUsecaseParam(companyDto: companyDto));

    if (result == null) {
      loading.value = false;
      failure.value = UnExpectedFailure(message: UnExpectedException().message);
      AppSnackBar.failure(
          failure: UnExpectedFailure(message: UnExpectedException().message));
    } else {
      result.fold((l) {
        loading.value = false;
        failure.value = l;
        AppSnackBar.failure(failure: l);
      }, (r) {
        loading.value = false;
        if (r.data != null) {
          Get.dialog(const OnAddBusinessAddModal());
          // AppSnackBar.success(
          //     title: 'company_added_succesfully_title',
          //     message: context.tr('company_added_succesfully_desc'));
        }
      });
    }
  }

  Future findUser({bool local = true}) async {
    failure.value = null;
    failure.refresh();
    loading.value = true;

    final result = await _getUser(param: GetUserUsecaseNoParam(local: local));

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
          dto.value.userId = r.data?.id ?? -1;
        }
        loading.value = false;
      });
    }
  }

  Future findTags({String? search}) async {
    final result = await _findTag(param: FindTagUsecaseParam(search: search));

    if (result != null) {
      result.fold((l) {
        print('loading tag error ${l.message}');
      }, (r) {
        tags.value = r.datas ?? [];
        tags.refresh();
      });
    }
  }
}
