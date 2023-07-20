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
    as _i9;
import 'package:linko/injectable/external.package.injection.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../src/auth/data/datasources/auth.local.datasource.dart' as _i4;
import '../src/auth/data/datasources/auth.remote.datasource.dart' as _i6;
import '../src/auth/data/respositories/auth.repository.dart' as _i11;
import '../src/auth/domain/respositories/i.auth.repository.dart' as _i10;
import '../src/auth/domain/usecases/confirm.phone.confirmation.code.dart'
    as _i15;
import '../src/auth/domain/usecases/get.token.dart' as _i16;
import '../src/auth/domain/usecases/resend.phone.confirmation.code.dart'
    as _i12;
import '../src/auth/domain/usecases/sign.out.dart' as _i13;
import '../src/auth/domain/usecases/verify.phone.dart' as _i14;
import '../src/auth/presentation/bloc/auth.state.bloc.dart' as _i17;
import '../src/core/network/network.info.dart' as _i8;

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
    gh.singleton<_i4.AuthLocalDataSource>(_i4.AuthLocalDataSource(
        sharedPreferences: gh<_i5.SharedPreferences>()));
    gh.singleton<_i6.AuthRemoteDataSource>(
        _i6.AuthRemoteDataSource(client: gh<_i7.Client>()));
    gh.singleton<_i8.INetworkInfo>(
        _i8.NetworkInfoImp(connectionChecker: gh<_i9.InternetConnection>()));
    gh.singleton<_i10.IAuthRepository>(_i11.AuthRepository(
      networkInfo: gh<_i8.INetworkInfo>(),
      authRemoteDataSource: gh<_i6.AuthRemoteDataSource>(),
      authLocalDataSource: gh<_i4.AuthLocalDataSource>(),
    ));
    gh.singleton<_i12.ResendPhoneConfirmationCode>(
        _i12.ResendPhoneConfirmationCode(
            signInRepository: gh<_i10.IAuthRepository>()));
    gh.singleton<_i13.SignOut>(
        _i13.SignOut(signInRepository: gh<_i10.IAuthRepository>()));
    gh.singleton<_i14.VerifyPhoneNumber>(
        _i14.VerifyPhoneNumber(signInRepository: gh<_i10.IAuthRepository>()));
    gh.singleton<_i15.ConfirmPhoneConfirmationCode>(
        _i15.ConfirmPhoneConfirmationCode(
            signInRepository: gh<_i10.IAuthRepository>()));
    gh.singleton<_i16.GetToken>(
        _i16.GetToken(authRepository: gh<_i10.IAuthRepository>()));
    gh.singleton<_i17.AuthStateBloc>(_i17.AuthStateBloc(
      verifyPhoneNumber: gh<_i14.VerifyPhoneNumber>(),
      getToken: gh<_i16.GetToken>(),
      resendPhoneConfirmationCode: gh<_i12.ResendPhoneConfirmationCode>(),
      signOut: gh<_i13.SignOut>(),
      confirmPhoneConfirmationCode: gh<_i15.ConfirmPhoneConfirmationCode>(),
    ));
    return this;
  }
}
