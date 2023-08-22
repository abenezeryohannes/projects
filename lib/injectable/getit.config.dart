// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i15;
import 'package:linko/injectable/external.package.injection.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../src/appcore/network/network.info.dart' as _i14;
import '../src/application/auth/auth.state.bloc.dart' as _i52;
import '../src/application/chat/chat.company.list.controller.dart' as _i53;
import '../src/application/chat/chat.controller.dart' as _i54;
import '../src/application/chat/history.controller.dart' as _i50;
import '../src/application/company/company.controller.dart' as _i55;
import '../src/application/user/favorite.controller.dart' as _i56;
import '../src/application/user/profile.controller.dart' as _i51;
import '../src/domain/auth/respositories/i.auth.repository.dart' as _i20;
import '../src/domain/auth/usecases/confirm.phone.confirmation.code.dart'
    as _i41;
import '../src/domain/auth/usecases/resend.phone.confirmation.code.usecase.dart'
    as _i32;
import '../src/domain/auth/usecases/sign.out.usecase.dart' as _i34;
import '../src/domain/auth/usecases/sign.up.usecase.dart' as _i35;
import '../src/domain/auth/usecases/verify.phone.usecase.dart' as _i37;
import '../src/domain/chat/repositories/i.chat.repository.dart' as _i22;
import '../src/domain/chat/usecases/clear.chata.usecase.dart' as _i39;
import '../src/domain/chat/usecases/clear.history.usecase.dart' as _i40;
import '../src/domain/chat/usecases/findAll.chat.company.usecase.dart' as _i44;
import '../src/domain/chat/usecases/findAll.chat.usecase.dart' as _i45;
import '../src/domain/company/repositories/i.company.repository.dart' as _i24;
import '../src/domain/company/repositories/i.tag.repository.dart' as _i28;
import '../src/domain/company/usecases/add.company.usecase.dart' as _i38;
import '../src/domain/company/usecases/find.tag.usecase.dart' as _i48;
import '../src/domain/user/repositories/i.favorite.repository.dart' as _i26;
import '../src/domain/user/repositories/i.user.repository.dart' as _i30;
import '../src/domain/user/usecases/delete.user.usecase.dart' as _i42;
import '../src/domain/user/usecases/edit.user.usecase.dart' as _i43;
import '../src/domain/user/usecases/find.favorite.usecase.dart' as _i46;
import '../src/domain/user/usecases/find.favorites.usecase.dart' as _i47;
import '../src/domain/user/usecases/get.user.usecase.dart' as _i49;
import '../src/domain/user/usecases/set.favorites.usecase.dart' as _i33;
import '../src/domain/user/usecases/unset.favorites.usecase.dart' as _i36;
import '../src/infrastructure/auth/datasources/auth.local.datasource.dart'
    as _i4;
import '../src/infrastructure/auth/datasources/auth.remote.datasource.dart'
    as _i6;
import '../src/infrastructure/auth/respositories/auth.repository.dart' as _i21;
import '../src/infrastructure/chat/datasources/chat.local.datasource.dart'
    as _i8;
import '../src/infrastructure/chat/datasources/chat.remote.datasource.dart'
    as _i9;
import '../src/infrastructure/chat/respositories/chat.repository.dart' as _i23;
import '../src/infrastructure/company/datasources/company/company.local.datasource.dart'
    as _i10;
import '../src/infrastructure/company/datasources/company/company.remote.datasource.dart'
    as _i11;
import '../src/infrastructure/company/datasources/tag/tag.local.datasource.dart'
    as _i16;
import '../src/infrastructure/company/datasources/tag/tag.remote.datasource.dart'
    as _i17;
import '../src/infrastructure/company/respositories/company.repository.dart'
    as _i25;
import '../src/infrastructure/company/respositories/tag.repository.dart'
    as _i29;
import '../src/infrastructure/user/datasources/favorite/favorite.local.datasource.dart'
    as _i12;
import '../src/infrastructure/user/datasources/favorite/favorite.remote.datasource.dart'
    as _i13;
import '../src/infrastructure/user/datasources/user/user.local.datasource.dart'
    as _i18;
import '../src/infrastructure/user/datasources/user/user.remote.datasource.dart'
    as _i19;
import '../src/infrastructure/user/respositories/favorite.repository.dart'
    as _i27;
import '../src/infrastructure/user/respositories/user.repository.dart' as _i31;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i3.ExternalPackageInjection().init(gh);
    gh.lazySingleton<_i4.AuthLocalDataSource>(
        () => _i4.AuthLocalDataSource(cache: gh<_i5.SharedPreferences>()));
    gh.singleton<_i6.AuthRemoteDataSource>(
        _i6.AuthRemoteDataSource(client: gh<_i7.Client>()));
    gh.lazySingleton<_i8.ChatLocalDataSource>(
        () => _i8.ChatLocalDataSource(cache: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i9.ChatRemoteDataSource>(
        () => _i9.ChatRemoteDataSource(client: gh<_i7.Client>()));
    gh.lazySingleton<_i10.CompanyLocalDataSource>(
        () => _i10.CompanyLocalDataSource(cache: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i11.CompanyRemoteDataSource>(
        () => _i11.CompanyRemoteDataSource(client: gh<_i7.Client>()));
    gh.lazySingleton<_i12.FavoriteLocalDataSource>(
        () => _i12.FavoriteLocalDataSource(cache: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i13.FavoriteRemoteDataSource>(
        () => _i13.FavoriteRemoteDataSource(client: gh<_i7.Client>()));
    gh.singleton<_i14.INetworkInfo>(
        _i14.NetworkInfoImp(connectionChecker: gh<_i15.InternetConnection>()));
    gh.lazySingleton<_i16.TagLocalDataSource>(
        () => _i16.TagLocalDataSource(cache: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i17.TagRemoteDataSource>(
        () => _i17.TagRemoteDataSource(client: gh<_i7.Client>()));
    gh.lazySingleton<_i18.UserLocalDataSource>(
        () => _i18.UserLocalDataSource(cache: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i19.UserRemoteDataSource>(
        () => _i19.UserRemoteDataSource(client: gh<_i7.Client>()));
    gh.singleton<_i20.IAuthRepository>(_i21.AuthRepository(
      networkInfo: gh<_i14.INetworkInfo>(),
      authRemoteDataSource: gh<_i6.AuthRemoteDataSource>(),
      authLocalDataSource: gh<_i4.AuthLocalDataSource>(),
    ));
    gh.lazySingleton<_i22.IChatRepository>(() => _i23.ChatRepositoryImp(
          localDataSource: gh<_i8.ChatLocalDataSource>(),
          remoteDataSource: gh<_i9.ChatRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.lazySingleton<_i24.ICompanyRepository>(() => _i25.CompanyRepositoryImp(
          localDataSource: gh<_i10.CompanyLocalDataSource>(),
          remoteDataSource: gh<_i11.CompanyRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.lazySingleton<_i26.IFavoriteRepository>(() => _i27.FavoriteRepositoryImp(
          localDataSource: gh<_i12.FavoriteLocalDataSource>(),
          remoteDataSource: gh<_i13.FavoriteRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.lazySingleton<_i28.ITagRepository>(() => _i29.TagRepositoryImp(
          localDataSource: gh<_i16.TagLocalDataSource>(),
          remoteDataSource: gh<_i17.TagRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.lazySingleton<_i30.IUserRepository>(() => _i31.UserRepositoryImp(
          localDataSource: gh<_i18.UserLocalDataSource>(),
          remoteDataSource: gh<_i19.UserRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.singleton<_i32.ResendPhoneConfirmationCodeUseCase>(
        _i32.ResendPhoneConfirmationCodeUseCase(
            signInRepository: gh<_i20.IAuthRepository>()));
    gh.lazySingleton<_i33.SetFavoriteUsecase>(() => _i33.SetFavoriteUsecase(
        favoriteRepository: gh<_i26.IFavoriteRepository>()));
    gh.singleton<_i34.SignOutUseCase>(
        _i34.SignOutUseCase(signInRepository: gh<_i20.IAuthRepository>()));
    gh.singleton<_i35.SignUpUseCase>(
        _i35.SignUpUseCase(authRepository: gh<_i20.IAuthRepository>()));
    gh.lazySingleton<_i36.UnsetFavoriteUsecase>(() => _i36.UnsetFavoriteUsecase(
        favoriteRepository: gh<_i26.IFavoriteRepository>()));
    gh.singleton<_i37.VerifyPhoneNumberUseCase>(_i37.VerifyPhoneNumberUseCase(
        signInRepository: gh<_i20.IAuthRepository>()));
    gh.lazySingleton<_i38.AddCompanyUsecase>(() => _i38.AddCompanyUsecase(
        companyRepository: gh<_i24.ICompanyRepository>()));
    gh.lazySingleton<_i39.ClearChatUsecase>(() =>
        _i39.ClearChatUsecase(chatRepository: gh<_i22.IChatRepository>()));
    gh.lazySingleton<_i40.ClearHistoryUsecase>(() =>
        _i40.ClearHistoryUsecase(chatRepository: gh<_i22.IChatRepository>()));
    gh.singleton<_i41.ConfirmPhoneConfirmationCodeUseCase>(
        _i41.ConfirmPhoneConfirmationCodeUseCase(
            signInRepository: gh<_i20.IAuthRepository>()));
    gh.lazySingleton<_i42.DeleteUserUsecase>(() =>
        _i42.DeleteUserUsecase(userRepository: gh<_i30.IUserRepository>()));
    gh.lazySingleton<_i43.EditUserUsecase>(
        () => _i43.EditUserUsecase(userRepository: gh<_i30.IUserRepository>()));
    gh.lazySingleton<_i44.FindAllChatCompanyUsecase>(() =>
        _i44.FindAllChatCompanyUsecase(
            chatRepository: gh<_i22.IChatRepository>()));
    gh.lazySingleton<_i45.FindAllChatUsecase>(() =>
        _i45.FindAllChatUsecase(chatRepository: gh<_i22.IChatRepository>()));
    gh.lazySingleton<_i46.FindFavoriteUsecase>(() => _i46.FindFavoriteUsecase(
        favoriteRepository: gh<_i26.IFavoriteRepository>()));
    gh.lazySingleton<_i47.FindFavoritesUsecase>(() => _i47.FindFavoritesUsecase(
        favoriteRepository: gh<_i26.IFavoriteRepository>()));
    gh.lazySingleton<_i48.FindTagUsecase>(
        () => _i48.FindTagUsecase(tagRepository: gh<_i28.ITagRepository>()));
    gh.lazySingleton<_i49.GetUserUsecase>(
        () => _i49.GetUserUsecase(userRepository: gh<_i30.IUserRepository>()));
    gh.factory<_i50.HistoryController>(() => _i50.HistoryController(
          gh<_i49.GetUserUsecase>(),
          gh<_i45.FindAllChatUsecase>(),
          gh<_i40.ClearHistoryUsecase>(),
        ));
    gh.factory<_i51.ProfileController>(() => _i51.ProfileController(
          gh<_i49.GetUserUsecase>(),
          gh<_i43.EditUserUsecase>(),
        ));
    gh.factory<_i52.AuthStateBloc>(() => _i52.AuthStateBloc(
          verifyPhoneNumber: gh<_i37.VerifyPhoneNumberUseCase>(),
          signUp: gh<_i35.SignUpUseCase>(),
          resendPhoneConfirmationCode:
              gh<_i32.ResendPhoneConfirmationCodeUseCase>(),
          signOut: gh<_i34.SignOutUseCase>(),
          confirmPhoneConfirmationCode:
              gh<_i41.ConfirmPhoneConfirmationCodeUseCase>(),
        ));
    gh.factory<_i53.ChatCompanyListController>(() =>
        _i53.ChatCompanyListController(gh<_i44.FindAllChatCompanyUsecase>()));
    gh.factory<_i54.ChatController>(() => _i54.ChatController(
          gh<_i49.GetUserUsecase>(),
          gh<_i45.FindAllChatUsecase>(),
        ));
    gh.factory<_i55.CompanyController>(() => _i55.CompanyController(
          gh<_i38.AddCompanyUsecase>(),
          gh<_i49.GetUserUsecase>(),
          gh<_i48.FindTagUsecase>(),
        ));
    gh.factory<_i56.FavoriteController>(() => _i56.FavoriteController(
          gh<_i49.GetUserUsecase>(),
          gh<_i47.FindFavoritesUsecase>(),
        ));
    return this;
  }
}
