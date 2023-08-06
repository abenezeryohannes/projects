import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/appcore/errors/exceptions.dart';
import 'package:linko/src/appcore/errors/failure.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';
import 'package:linko/src/domain/user/usecases/find.favorites.usecase.dart';
import 'package:linko/src/domain/user/usecases/get.user.usecase.dart';
import 'package:linko/src/infrastructure/user/dtos/user.dto.dart';

@injectable
class FavoriteController extends GetxController {
  final GetUserUsecase _findUserUsecase;
  final FindFavoritesUsecase _findFavoritesUsecase;

  FavoriteController(this._findUserUsecase, this._findFavoritesUsecase);

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  Rx<UserDto?> userDto = Rx<UserDto?>(null);
  RxBool loading = RxBool(false);
  Rx<Failure?> failure = Rx<Failure?>(null);
  RxList favorites = RxList.empty();
  Rx<WrapperDto<FavoriteEntity>?> wrapper =
      Rx<WrapperDto<FavoriteEntity>?>(null);

  static const _pageSize = 25;

  final PagingController<int, FavoriteEntity?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future findAll(
      {int limit = _pageSize,
      int page = 1,
      int? lastID,
      String? search}) async {
    final result = await _findFavoritesUsecase(
        param: FindFavoritesUsecaseParam(
      limit: limit,
      page: page,
      lastID: lastID,
      search: search,
    ));
    if (result == null) {
      pagingController.error = Failure(message: UnExpectedException().message);
    } else {
      result.fold((l) {
        pagingController.error = l;
      }, (r) {
        wrapper.value = r;
        final isLastPage = (r.datas?.length ?? 0) < (_pageSize);
        if (isLastPage) {
          if (r.datas != null) {
            pagingController.appendLastPage(r.datas!.cast<FavoriteEntity?>());
          }
        } else {
          if (r.datas != null) {
            pagingController.appendPage(
                r.datas!.cast<FavoriteEntity?>(), page + 1);
          }
        }
      });
    }
  }

  Future find({bool local = true}) async {
    final result =
        await _findUserUsecase(param: GetUserUsecaseNoParam(local: local));
    if (result == null) {
    } else {
      result.fold((l) {}, (r) {
        if (r.data != null) {
          user.value = r.data;
          userDto.value = UserDto.fromEntity(r.data!);
        }
      });
    }
  }
}
