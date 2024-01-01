import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/core/errors/exceptions.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/widgets/app.snackbar.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/category.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/create.complaint.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/add.complaint.usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/get.complaint.categories.usecase.dart';
import 'package:rnginfra/src/residents/visitors/domain/usecases/helpdesk/upload.complaint.image.dart';

import '../../../../../guards/activity/domain/entities/file.entity.dart';
import '../../../domain/entities/help.request.type.dart';
import '../widgets/add.images.form.dart';

@injectable
class RaiseComplaintController extends GetxController {
  final AddComplaintUseCase _addComplaintUseCase;
  final UploadComplaintImageUseCase _uploadComplaintImageUseCase;
  final GetComplaintCategoriesUseCase _getComplaintCategoriesUseCase;
  RaiseComplaintController(this._addComplaintUseCase,
      this._getComplaintCategoriesUseCase, this._uploadComplaintImageUseCase);

  Rx<CreateComplaintEntity> createComplaint =
      Rx<CreateComplaintEntity>(CreateComplaintEntity());
  Rx<ComplaintEntity?> complaint = Rx<ComplaintEntity?>(null);
  RxList<CategoryEntity> categories = RxList([]);
  RxList<CategoryEntity> subCategories = RxList([]);
  RxList<BulkImageDto> images = RxList([]);
  Rx<CategoryEntity?> selectedCategory = Rx<CategoryEntity?>(null);
  Rx<CategoryEntity?> selectedSubCategory = Rx<CategoryEntity?>(null);
  RxBool loading = RxBool(false);
  RxBool urgent = RxBool(false);
  HelpRequestType requestType = HelpRequestType.UNIT_LEVEL;

  save(
    BuildContext context,
    Function(bool) load,
  ) async {
    if (prepare()) {
      return;
    }
    load(true);
    final result = await _addComplaintUseCase(
        AddComplaintParam(complaint: createComplaint.value));
    load(false);

    if (result == null) {
      AppSnackBar.failure(
          failure: Failure(message: UnExpectedException().message));
      return;
    }
    if (result.isLeft()) {
      AppSnackBar.failure(failure: (result as Left).value);
    } else if (result.isRight()) {
      AppSnackBar.success(
          title: "Success", message: 'Complaint raised successfully!');
      Navigator.of(context).maybePop<bool>(true);
      // Get.back<bool>(result: true);
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
        final isLastPage = (r.results.length) < (limit ?? 0);
        if (isLastPage) {
          categories.value = r.results;
          categories.refresh();
        }
      });
    }
  }

  Future<FileEntity?> uploadImage(
      {required Function(bool) load,
      String? file,
      required Function(BulkImageDto) onUploaded}) async {
    onUploaded(BulkImageDto(localImg: file, img: null));
    if (file != null && file.trim().isNotEmpty) {
      load(true);
      final result = await _uploadComplaintImageUseCase(
          UploadComplaintImageParam(file: file));
      if (result == null) {
        AppSnackBar.failure(
            failure: Failure(message: UnExpectedException().message));
        load(false);
        return null;
      } else {
        if (result.isLeft()) {
          AppSnackBar.failure(failure: (result as Left).value);
          load(false);
          images.removeWhere((r) => r.localImg == file);
          images.refresh();
        } else if (result.isRight()) {
          load(false);
          createComplaint.value.field_image ??= [];
          if (result.getOrElse(() => FileEntity(fid: null)).fid != null) {
            createComplaint.value.field_image!
                .add(result.getOrElse(() => FileEntity(fid: null)).fid!);
          }
          final resp = result.getOrElse(() => FileEntity(fid: -1));
          images.removeWhere((r) => r.localImg == file);
          onUploaded(BulkImageDto(localImg: file, img: null));
          if (resp.fid == -1) return null;
          return resp;
        }
      }
    } else {
      return null;
    }
  }

  bool prepare() {
    createComplaint.value.field_complaint_category =
        int.tryParse(selectedCategory.value?.tid ?? '');
    createComplaint.value.field_complaint_type =
        requestType == HelpRequestType.UNIT_LEVEL
            ? 'unit_level'
            : 'community_level';
    createComplaint.value.field_complaint_urgent = urgent.value ? 1 : 0;
    if ((createComplaint.value.title?.length ?? 0) > 50) {
      AppSnackBar.warning(message: 'The title is too long!!');
      return true;
    }
    return false;
  }
}
