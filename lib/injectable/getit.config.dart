// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i15;
import 'package:linko/injectable/external.package.injection.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../src/appcore/network/network.info.dart' as _i14;
import '../src/application/auth/auth.state.bloc.dart' as _i44;
import '../src/application/chat/chat.controller.dart' as _i45;
import '../src/application/company/company.controller.dart' as _i46;
import '../src/application/user/profile.controller.dart' as _i43;
import '../src/domain/auth/respositories/i.auth.repository.dart' as _i22;
import '../src/domain/auth/usecases/confirm.phone.confirmation.code.dart'
    as _i37;
import '../src/domain/auth/usecases/resend.phone.confirmation.code.dart'
    as _i32;
import '../src/domain/auth/usecases/sign.out.dart' as _i33;
import '../src/domain/auth/usecases/sign.up.dart' as _i34;
import '../src/domain/auth/usecases/verify.phone.dart' as _i35;
import '../src/domain/chat/repositories/i.chat.repository.dart' as _i24;
import '../src/domain/chat/usecases/findAll.chat.usecase.dart' as _i40;
import '../src/domain/company/repositories/i.company.repository.dart' as _i26;
import '../src/domain/company/repositories/i.tag.repository.dart' as _i28;
import '../src/domain/company/usecases/add.company.usecase.dart' as _i36;
import '../src/domain/company/usecases/find.tag.usecase.dart' as _i41;
import '../src/domain/user/repositories/i.favorite.repository.dart' as _i5;
import '../src/domain/user/repositories/i.user.repository.dart' as _i30;
import '../src/domain/user/usecases/delete.user.usecase.dart' as _i38;
import '../src/domain/user/usecases/edit.user.usecase.dart' as _i39;
import '../src/domain/user/usecases/find.favorites.usecase.dart' as _i4;
import '../src/domain/user/usecases/get.user.usecase.dart' as _i42;
import '../src/domain/user/usecases/set.favorites.usecase.dart' as _i16;
import '../src/domain/user/usecases/unset.favorites.usecase.dart' as _i19;
import '../src/infrastructure/auth/datasources/auth.local.datasource.dart'
    as _i6;
import '../src/infrastructure/auth/datasources/auth.remote.datasource.dart'
    as _i8;
import '../src/infrastructure/auth/respositories/auth.repository.dart' as _i23;
import '../src/infrastructure/chat/datasources/chat.local.datasource.dart'
    as _i10;
import '../src/infrastructure/chat/datasources/chat.remote.datasource.dart'
    as _i11;
import '../src/infrastructure/chat/respositories/chat.repository.dart' as _i25;
import '../src/infrastructure/company/datasources/company/company.local.datasource.dart'
    as _i12;
import '../src/infrastructure/company/datasources/company/company.remote.datasource.dart'
    as _i13;
import '../src/infrastructure/company/datasources/tag/tag.local.datasource.dart'
    as _i17;
import '../src/infrastructure/company/datasources/tag/tag.remote.datasource.dart'
    as _i18;
import '../src/infrastructure/company/respositories/company.repository.dart'
    as _i27;
import '../src/infrastructure/company/respositories/tag.repository.dart'
    as _i29;
import '../src/infrastructure/user/datasources/user.local.datasource.dart'
    as _i20;
import '../src/infrastructure/user/datasources/user.remote.datasource.dart'
    as _i21;
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
    gh.lazySingleton<_i4.AddFavoriteUsecase>(() => _i4.AddFavoriteUsecase(
        favoriteRepository: gh<_i5.IFavoriteRepository>()));
    gh.lazySingleton<_i6.AuthLocalDataSource>(
        () => _i6.AuthLocalDataSource(cache: gh<_i7.SharedPreferences>()));
    gh.singleton<_i8.AuthRemoteDataSource>(
        _i8.AuthRemoteDataSource(client: gh<_i9.Client>()));
    gh.lazySingleton<_i10.ChatLocalDataSource>(
        () => _i10.ChatLocalDataSource(cache: gh<_i7.SharedPreferences>()));
    gh.lazySingleton<_i11.ChatRemoteDataSource>(
        () => _i11.ChatRemoteDataSource(client: gh<_i9.Client>()));
    gh.lazySingleton<_i12.CompanyLocalDataSource>(
        () => _i12.CompanyLocalDataSource(cache: gh<_i7.SharedPreferences>()));
    gh.lazySingleton<_i13.CompanyRemoteDataSource>(
        () => _i13.CompanyRemoteDataSource(client: gh<_i9.Client>()));
    gh.singleton<_i14.INetworkInfo>(
        _i14.NetworkInfoImp(connectionChecker: gh<_i15.InternetConnection>()));
    gh.lazySingleton<_i16.SetFavoriteUsecase>(() => _i16.SetFavoriteUsecase(
        favoriteRepository: gh<_i5.IFavoriteRepository>()));
    gh.lazySingleton<_i17.TagLocalDataSource>(
        () => _i17.TagLocalDataSource(cache: gh<_i7.SharedPreferences>()));
    gh.lazySingleton<_i18.TagRemoteDataSource>(
        () => _i18.TagRemoteDataSource(client: gh<_i9.Client>()));
    gh.lazySingleton<_i19.UnsetFavoriteUsecase>(() => _i19.UnsetFavoriteUsecase(
        favoriteRepository: gh<_i5.IFavoriteRepository>()));
    gh.lazySingleton<_i20.UserLocalDataSource>(
        () => _i20.UserLocalDataSource(cache: gh<_i7.SharedPreferences>()));
    gh.lazySingleton<_i21.UserRemoteDataSource>(
        () => _i21.UserRemoteDataSource(client: gh<_i9.Client>()));
    gh.singleton<_i22.IAuthRepository>(_i23.AuthRepository(
      networkInfo: gh<_i14.INetworkInfo>(),
      authRemoteDataSource: gh<_i8.AuthRemoteDataSource>(),
      authLocalDataSource: gh<_i6.AuthLocalDataSource>(),
    ));
    gh.lazySingleton<_i24.IChatRepository>(() => _i25.ChatRepositoryImp(
          localDataSource: gh<_i10.ChatLocalDataSource>(),
          remoteDataSource: gh<_i11.ChatRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.lazySingleton<_i26.ICompanyRepository>(() => _i27.CompanyRepositoryImp(
          localDataSource: gh<_i12.CompanyLocalDataSource>(),
          remoteDataSource: gh<_i13.CompanyRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.lazySingleton<_i28.ITagRepository>(() => _i29.TagRepositoryImp(
          localDataSource: gh<_i17.TagLocalDataSource>(),
          remoteDataSource: gh<_i18.TagRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.lazySingleton<_i30.IUserRepository>(() => _i31.UserRepositoryImp(
          localDataSource: gh<_i20.UserLocalDataSource>(),
          remoteDataSource: gh<_i21.UserRemoteDataSource>(),
          networkInfo: gh<_i14.INetworkInfo>(),
        ));
    gh.singleton<_i32.ResendPhoneConfirmationCode>(
        _i32.ResendPhoneConfirmationCode(
            signInRepository: gh<_i22.IAuthRepository>()));
    gh.singleton<_i33.SignOut>(
        _i33.SignOut(signInRepository: gh<_i22.IAuthRepository>()));
    gh.singleton<_i34.SignUp>(
        _i34.SignUp(authRepository: gh<_i22.IAuthRepository>()));
    gh.singleton<_i35.VerifyPhoneNumber>(
        _i35.VerifyPhoneNumber(signInRepository: gh<_i22.IAuthRepository>()));
    gh.lazySingleton<_i36.AddCompanyUsecase>(() => _i36.AddCompanyUsecase(
        companyRepository: gh<_i26.ICompanyRepository>()));
    gh.singleton<_i37.ConfirmPhoneConfirmationCode>(
        _i37.ConfirmPhoneConfirmationCode(
            signInRepository: gh<_i22.IAuthRepository>()));
    gh.lazySingleton<_i38.DeleteUserUsecase>(() =>
        _i38.DeleteUserUsecase(userRepository: gh<_i30.IUserRepository>()));
    gh.lazySingleton<_i39.EditUserUsecase>(
        () => _i39.EditUserUsecase(userRepository: gh<_i30.IUserRepository>()));
    gh.lazySingleton<_i40.FindAllChatUsecase>(() =>
        _i40.FindAllChatUsecase(chatRepository: gh<_i24.IChatRepository>()));
    gh.lazySingleton<_i41.FindTagUsecase>(
        () => _i41.FindTagUsecase(tagRepository: gh<_i28.ITagRepository>()));
    gh.lazySingleton<_i42.GetUserUsecase>(
        () => _i42.GetUserUsecase(userRepository: gh<_i30.IUserRepository>()));
    gh.factory<_i43.ProfileController>(() => _i43.ProfileController(
          gh<_i42.GetUserUsecase>(),
          gh<_i39.EditUserUsecase>(),
        ));
    gh.factory<_i44.AuthStateBloc>(() => _i44.AuthStateBloc(
          verifyPhoneNumber: gh<_i35.VerifyPhoneNumber>(),
          signUp: gh<_i34.SignUp>(),
          resendPhoneConfirmationCode: gh<_i32.ResendPhoneConfirmationCode>(),
          signOut: gh<_i33.SignOut>(),
          confirmPhoneConfirmationCode: gh<_i37.ConfirmPhoneConfirmationCode>(),
        ));
    gh.factory<_i45.ChatController>(() => _i45.ChatController(
          gh<_i42.GetUserUsecase>(),
          gh<_i40.FindAllChatUsecase>(),
        ));
    gh.factory<_i46.CompanyController>(() => _i46.CompanyController(
          gh<_i36.AddCompanyUsecase>(),
          gh<_i42.GetUserUsecase>(),
          gh<_i41.FindTagUsecase>(),
        ));
    return this;
  }
}
