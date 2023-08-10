import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/exceptions.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/domain/chat/usecases/findAll.chat.company.usecase.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/infrastructure/user/dtos/user.dto.dart';

@injectable
class ChatCompanyListController extends GetxController {
  final FindAllChatCompanyUsecase _findCompaniesWithId;

  ChatCompanyListController(this._findCompaniesWithId);

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  Rx<UserDto?> userDto = Rx<UserDto?>(null);
  RxBool loading = RxBool(false);
  Rx<Failure?> failure = Rx<Failure?>(null);
  RxList favorites = RxList.empty();
  Rx<WrapperDto<CompanyEntity>?> wrapper = Rx<WrapperDto<CompanyEntity>?>(null);

  static const _pageSize = 10;

  RxBool isLastPage = false.obs;
  RxInt nextPageKey = 1.obs;

  final PagingController<int, CompanyEntity?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future findAll(
      {int limit = _pageSize, int page = 1, required List<int> ids}) async {
    final result = await _findCompaniesWithId(
        param:
            FindAllChatCompanyUsecaseParam(ids: ids, page: page, limit: limit));

    if (result == null) {
      pagingController.error = Failure(message: UnExpectedException().message);
    } else {
      result.fold((l) {
        pagingController.error = l;
      }, (r) {
        wrapper.value = r;
        isLastPage.value = (r.datas?.length ?? 0) < (_pageSize);
        nextPageKey.value = page + 1;
        if (isLastPage.value) {
          if (r.datas != null) {
            pagingController.appendLastPage(r.datas!.cast<CompanyEntity?>());
          }
        } else {
          if (r.datas != null) {
            pagingController.appendLastPage(r.datas!.cast<CompanyEntity?>());
          }
        }
      });
    }
  }
}
