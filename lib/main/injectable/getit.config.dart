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
    as _i11;
import 'package:rnginfra/main/injectable/external.package.injection.dart'
    as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../../src/auth/data/datasources/auth.local.datasource.dart' as _i8;
import '../../src/auth/data/datasources/auth.remote.datasource.dart' as _i9;
import '../../src/auth/data/respositories/auth.repository.dart' as _i19;
import '../../src/auth/domain/respositories/i.auth.repository.dart' as _i18;
import '../../src/auth/domain/usecases/confirm.phone.confirmation.code.dart'
    as _i35;
import '../../src/auth/domain/usecases/get.token.dart' as _i50;
import '../../src/auth/domain/usecases/resend.phone.confirmation.code.dart'
    as _i26;
import '../../src/auth/domain/usecases/sign.out.dart' as _i27;
import '../../src/auth/domain/usecases/verify.phone.dart' as _i29;
import '../../src/auth/presentation/bloc/auth.state.bloc.dart' as _i59;
import '../../src/core/network/network.info.dart' as _i10;
import '../../src/guards/activity/data/datasources/activity.local.datasource.dart'
    as _i4;
import '../../src/guards/activity/data/datasources/activity.remote.datasource.dart'
    as _i6;
import '../../src/guards/activity/data/repositories/activity.repository.dart'
    as _i17;
import '../../src/guards/activity/domain/repositories/i.activities.repository.dart'
    as _i16;
import '../../src/guards/activity/domain/usecases/add.guest.activity.usecase.dart'
    as _i30;
import '../../src/guards/activity/domain/usecases/add.staff.attendance.usecase.dart'
    as _i32;
import '../../src/guards/activity/domain/usecases/check.visitor.passcode.usecase.dart'
    as _i34;
import '../../src/guards/activity/domain/usecases/edit.guest.activity.usecase.dart'
    as _i37;
import '../../src/guards/activity/domain/usecases/edit.staff.attendance.usecase.dart'
    as _i39;
import '../../src/guards/activity/domain/usecases/get.activity.types.usecase.dart'
    as _i41;
import '../../src/guards/activity/domain/usecases/get.guests.activities.usecase.dart'
    as _i43;
import '../../src/guards/activity/domain/usecases/get.guests.usecase.dart'
    as _i44;
import '../../src/guards/activity/domain/usecases/get.local.guests.activities.usecase.dart'
    as _i42;
import '../../src/guards/activity/domain/usecases/get.local.staffs.activities.usecase.dart'
    as _i48;
import '../../src/guards/activity/domain/usecases/get.residents.usecase.dart'
    as _i46;
import '../../src/guards/activity/domain/usecases/get.staffs.activities.usecase.dart'
    as _i47;
import '../../src/guards/activity/domain/usecases/get.staffs.usecase.dart'
    as _i49;
import '../../src/guards/activity/domain/usecases/upload.file.usecase.dart'
    as _i28;
import '../../src/guards/activity/presentation/guests/bloc/guest_activity_bloc.dart'
    as _i52;
import '../../src/guards/activity/presentation/guests/controller/add.guest.activity.controller.dart'
    as _i56;
import '../../src/guards/activity/presentation/staffs/bloc/staff_activity_bloc.dart'
    as _i55;
import '../../src/guards/activity/presentation/staffs/controllers/add.staff.attendance.controller.dart'
    as _i57;
import '../../src/guards/activity/presentation/staffs/controllers/edit.staff.attendance.controller.dart'
    as _i60;
import '../../src/guards/patroll/data/datasources/patroll.local.data.source.dart'
    as _i12;
import '../../src/guards/patroll/data/datasources/patroll.remote.data.source.dart'
    as _i13;
import '../../src/guards/patroll/data/repositories/patroll.repository.dart'
    as _i21;
import '../../src/guards/patroll/domain/repositories/i.patroll.repository.dart'
    as _i20;
import '../../src/guards/patroll/domain/usecases/add.patroll.usecase.dart'
    as _i31;
import '../../src/guards/patroll/domain/usecases/delete.patroll.usecase.dart'
    as _i36;
import '../../src/guards/patroll/domain/usecases/edit.patroll.usecase.dart'
    as _i38;
import '../../src/guards/patroll/domain/usecases/list.local.patroll.usecase.dart'
    as _i25;
import '../../src/guards/patroll/domain/usecases/list.patroll.usecase.dart'
    as _i24;
import '../../src/guards/patroll/presentation/patrolls_list/bloc/patroll_bloc.dart'
    as _i53;
import '../../src/guards/patroll/presentation/scan_patrolls/controller/scan.patroll.controller.dart'
    as _i54;
import '../../src/residents/visitors/data/datasources/visitor.local.datasource.dart'
    as _i14;
import '../../src/residents/visitors/data/datasources/visitor.remote.datasource.dart'
    as _i15;
import '../../src/residents/visitors/data/repositories/visitor.repository.dart'
    as _i23;
import '../../src/residents/visitors/domain/repositories/i.visitors.repository.dart'
    as _i22;
import '../../src/residents/visitors/domain/usecases/add.visitor.activity.usecase.dart'
    as _i33;
import '../../src/residents/visitors/domain/usecases/edit.visitors.usecase.dart'
    as _i40;
import '../../src/residents/visitors/domain/usecases/get.local.visitors.usecase.dart'
    as _i45;
import '../../src/residents/visitors/domain/usecases/get.visitor.activities.usecase.dart'
    as _i51;
import '../../src/residents/visitors/presentation/visitors/controller/add.visitor.activity.controller.dart'
    as _i58;
import '../../src/residents/visitors/presentation/visitors/controller/get.visitor.activities.controller.dart'
    as _i61;

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
    gh.singleton<_i4.ActivityLocalDatasource>(
        _i4.ActivityLocalDatasource(cache: gh<_i5.SharedPreferences>()));
    gh.singleton<_i6.ActivityRemoteDatasource>(
        _i6.ActivityRemoteDatasource(client: gh<_i7.Client>()));
    gh.singleton<_i8.AuthLocalDataSource>(_i8.AuthLocalDataSource(
        sharedPreferences: gh<_i5.SharedPreferences>()));
    gh.singleton<_i9.AuthRemoteDataSource>(
        _i9.AuthRemoteDataSource(client: gh<_i7.Client>()));
    gh.singleton<_i10.INetworkInfo>(
        _i10.NetworkInfoImp(connectionChecker: gh<_i11.InternetConnection>()));
    gh.singleton<_i12.PatrollLocalDataSource>(
        _i12.PatrollLocalDataSource(cache: gh<_i5.SharedPreferences>()));
    gh.singleton<_i13.PatrollRemoteDataSource>(
        _i13.PatrollRemoteDataSource(client: gh<_i7.Client>()));
    gh.lazySingleton<_i14.VisitorLocalDatasource>(
        () => _i14.VisitorLocalDatasource(cache: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i15.VisitorRemoteDatasource>(
        () => _i15.VisitorRemoteDatasource(client: gh<_i7.Client>()));
    gh.singleton<_i16.IActivityRepository>(_i17.ActivityRepository(
      networkInfo: gh<_i10.INetworkInfo>(),
      remoteDataSource: gh<_i6.ActivityRemoteDatasource>(),
      localDataSource: gh<_i4.ActivityLocalDatasource>(),
    ));
    gh.singleton<_i18.IAuthRepository>(_i19.AuthRepository(
      networkInfo: gh<_i10.INetworkInfo>(),
      authRemoteDataSource: gh<_i9.AuthRemoteDataSource>(),
      authLocalDataSource: gh<_i8.AuthLocalDataSource>(),
    ));
    gh.singleton<_i20.IPatrollRepository>(_i21.PatrollRepository(
      networkInfo: gh<_i10.INetworkInfo>(),
      remoteDataSource: gh<_i13.PatrollRemoteDataSource>(),
      localDataSource: gh<_i12.PatrollLocalDataSource>(),
    ));
    gh.lazySingleton<_i22.IVisitorsRepository>(() => _i23.VisitorRepository(
          networkInfo: gh<_i10.INetworkInfo>(),
          remoteDataSource: gh<_i15.VisitorRemoteDatasource>(),
          localDataSource: gh<_i14.VisitorLocalDatasource>(),
        ));
    gh.singleton<_i24.ListPatrollUseCase>(_i24.ListPatrollUseCase(
        patrollRepository: gh<_i20.IPatrollRepository>()));
    gh.singleton<_i25.ListPatrollUseCase>(_i25.ListPatrollUseCase(
        patrollRepository: gh<_i20.IPatrollRepository>()));
    gh.singleton<_i26.ResendPhoneConfirmationCode>(
        _i26.ResendPhoneConfirmationCode(
            signInRepository: gh<_i18.IAuthRepository>()));
    gh.singleton<_i27.SignOut>(
        _i27.SignOut(signInRepository: gh<_i18.IAuthRepository>()));
    gh.singleton<_i28.UploadFileUseCase>(
        _i28.UploadFileUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i29.VerifyPhoneNumber>(
        _i29.VerifyPhoneNumber(signInRepository: gh<_i18.IAuthRepository>()));
    gh.singleton<_i30.AddGuestActivityUseCase>(
        _i30.AddGuestActivityUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i31.AddPatrollUseCase>(_i31.AddPatrollUseCase(
        patrollRepository: gh<_i20.IPatrollRepository>()));
    gh.singleton<_i32.AddStaffAttendanceUseCase>(
        _i32.AddStaffAttendanceUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i33.AddVisitorActivityUseCase>(
        _i33.AddVisitorActivityUseCase(repo: gh<_i22.IVisitorsRepository>()));
    gh.singleton<_i34.CheckVisitorPasscodeUseCase>(
        _i34.CheckVisitorPasscodeUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i35.ConfirmPhoneConfirmationCode>(
        _i35.ConfirmPhoneConfirmationCode(
            signInRepository: gh<_i18.IAuthRepository>()));
    gh.singleton<_i36.DeletePatrollUseCase>(_i36.DeletePatrollUseCase(
        patrollRepository: gh<_i20.IPatrollRepository>()));
    gh.singleton<_i37.EditGuestActivityUseCase>(
        _i37.EditGuestActivityUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i38.EditPatrollUseCase>(_i38.EditPatrollUseCase(
        patrollRepository: gh<_i20.IPatrollRepository>()));
    gh.singleton<_i39.EditStaffAttendanceUseCase>(
        _i39.EditStaffAttendanceUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i40.EditVisitorActivityUseCase>(
        _i40.EditVisitorActivityUseCase(repo: gh<_i22.IVisitorsRepository>()));
    gh.singleton<_i41.GetActivityTypesUseCase>(
        _i41.GetActivityTypesUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i42.GetGuestsActivitiesUseCase>(
        _i42.GetGuestsActivitiesUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i43.GetGuestsActivitiesUseCase>(
        _i43.GetGuestsActivitiesUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i44.GetGuestsUseCase>(
        _i44.GetGuestsUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.lazySingleton<_i45.GetLocalVisitorActivitiesUseCase>(() =>
        _i45.GetLocalVisitorActivitiesUseCase(
            repo: gh<_i22.IVisitorsRepository>()));
    gh.singleton<_i46.GetResidentsUseCase>(
        _i46.GetResidentsUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i47.GetStaffsActivityUseCase>(
        _i47.GetStaffsActivityUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i48.GetStaffsActivityUseCase>(
        _i48.GetStaffsActivityUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i49.GetStaffsUseCase>(
        _i49.GetStaffsUseCase(repo: gh<_i16.IActivityRepository>()));
    gh.singleton<_i50.GetToken>(
        _i50.GetToken(authRepository: gh<_i18.IAuthRepository>()));
    gh.singleton<_i51.GetVisitorsActivitiesUseCase>(
        _i51.GetVisitorsActivitiesUseCase(
            repo: gh<_i22.IVisitorsRepository>()));
    gh.factory<_i52.GuestActivityBloc>(
        () => _i52.GuestActivityBloc(gh<_i43.GetGuestsActivitiesUseCase>()));
    gh.factory<_i53.PatrollBloc>(() => _i53.PatrollBloc(
          gh<_i31.AddPatrollUseCase>(),
          gh<_i38.EditPatrollUseCase>(),
          gh<_i24.ListPatrollUseCase>(),
          gh<_i36.DeletePatrollUseCase>(),
        ));
    gh.factory<_i54.ScanPatrollController>(() =>
        _i54.ScanPatrollController(useCase: gh<_i31.AddPatrollUseCase>()));
    gh.factory<_i55.StaffActivityBloc>(
        () => _i55.StaffActivityBloc(gh<_i47.GetStaffsActivityUseCase>()));
    gh.singleton<_i56.AddGuestActivityController>(
        _i56.AddGuestActivityController(
      getResidentsUseCase: gh<_i46.GetResidentsUseCase>(),
      uploadFileUseCase: gh<_i28.UploadFileUseCase>(),
      getActivityTypesUseCase: gh<_i41.GetActivityTypesUseCase>(),
      getStaffsUseCase: gh<_i49.GetStaffsUseCase>(),
      getGuestsUseCase: gh<_i44.GetGuestsUseCase>(),
      addGuestActivityUseCase: gh<_i30.AddGuestActivityUseCase>(),
      editGuestActivityUseCase: gh<_i37.EditGuestActivityUseCase>(),
      checkVisitorPasscodeUseCase: gh<_i34.CheckVisitorPasscodeUseCase>(),
    ));
    gh.factory<_i57.AddStaffAttendanceController>(
        () => _i57.AddStaffAttendanceController(
              addStaffAttendanceUseCase: gh<_i32.AddStaffAttendanceUseCase>(),
              getStaffsUseCase: gh<_i49.GetStaffsUseCase>(),
            ));
    gh.singleton<_i58.AddVisitorActivityController>(
        _i58.AddVisitorActivityController(
      getResidentsUseCase: gh<_i46.GetResidentsUseCase>(),
      getActivityTypesUseCase: gh<_i41.GetActivityTypesUseCase>(),
      getStaffsUseCase: gh<_i49.GetStaffsUseCase>(),
      getGuestsUseCase: gh<_i44.GetGuestsUseCase>(),
      addVisitorActivityUseCase: gh<_i33.AddVisitorActivityUseCase>(),
    ));
    gh.factory<_i59.AuthStateBloc>(() => _i59.AuthStateBloc(
          verifyPhoneNumber: gh<_i29.VerifyPhoneNumber>(),
          getToken: gh<_i50.GetToken>(),
          resendPhoneConfirmationCode: gh<_i26.ResendPhoneConfirmationCode>(),
          signOut: gh<_i27.SignOut>(),
          confirmPhoneConfirmationCode: gh<_i35.ConfirmPhoneConfirmationCode>(),
        ));
    gh.factory<_i60.EditStaffAttendanceController>(() =>
        _i60.EditStaffAttendanceController(
            editStaffAttendanceUseCase: gh<_i39.EditStaffAttendanceUseCase>()));
    gh.factory<_i61.GetVisitorActivitiesController>(() =>
        _i61.GetVisitorActivitiesController(
            gh<_i51.GetVisitorsActivitiesUseCase>()));
    return this;
  }
}
