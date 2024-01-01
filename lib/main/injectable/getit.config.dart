// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i16;
import 'package:rnginfra/main/injectable/external.package.injection.dart'
    as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../../src/auth/data/datasources/auth.local.datasource.dart' as _i8;
import '../../src/auth/data/datasources/auth.remote.datasource.dart' as _i9;
import '../../src/auth/data/respositories/auth.repository.dart' as _i26;
import '../../src/auth/domain/respositories/i.auth.repository.dart' as _i25;
import '../../src/auth/domain/usecases/confirm.phone.confirmation.code.dart'
    as _i48;
import '../../src/auth/domain/usecases/get.token.dart' as _i73;
import '../../src/auth/domain/usecases/resend.phone.confirmation.code.dart'
    as _i35;
import '../../src/auth/domain/usecases/sign.out.dart' as _i36;
import '../../src/auth/domain/usecases/verify.phone.dart' as _i39;
import '../../src/auth/presentation/bloc/auth.state.bloc.dart' as _i86;
import '../../src/core/network/network.info.dart' as _i15;
import '../../src/guards/activity/data/datasources/activity.local.datasource.dart'
    as _i4;
import '../../src/guards/activity/data/datasources/activity.remote.datasource.dart'
    as _i6;
import '../../src/guards/activity/data/repositories/activity.repository.dart'
    as _i24;
import '../../src/guards/activity/domain/repositories/i.activities.repository.dart'
    as _i23;
import '../../src/guards/activity/domain/usecases/add.guest.activity.usecase.dart'
    as _i43;
import '../../src/guards/activity/domain/usecases/add.staff.attendance.usecase.dart'
    as _i45;
import '../../src/guards/activity/domain/usecases/check.visitor.passcode.usecase.dart'
    as _i47;
import '../../src/guards/activity/domain/usecases/edit.guest.activity.usecase.dart'
    as _i51;
import '../../src/guards/activity/domain/usecases/edit.staff.attendance.usecase.dart'
    as _i53;
import '../../src/guards/activity/domain/usecases/get.activity.types.usecase.dart'
    as _i55;
import '../../src/guards/activity/domain/usecases/get.guests.activities.usecase.dart'
    as _i65;
import '../../src/guards/activity/domain/usecases/get.guests.usecase.dart'
    as _i66;
import '../../src/guards/activity/domain/usecases/get.local.guests.activities.usecase.dart'
    as _i64;
import '../../src/guards/activity/domain/usecases/get.local.staffs.activities.usecase.dart'
    as _i70;
import '../../src/guards/activity/domain/usecases/get.residents.usecase.dart'
    as _i69;
import '../../src/guards/activity/domain/usecases/get.staffs.activities.usecase.dart'
    as _i71;
import '../../src/guards/activity/domain/usecases/get.staffs.usecase.dart'
    as _i72;
import '../../src/guards/activity/domain/usecases/upload.file.usecase.dart'
    as _i38;
import '../../src/guards/activity/presentation/guests/bloc/guest_activity_bloc.dart'
    as _i75;
import '../../src/guards/activity/presentation/guests/controller/add.guest.activity.controller.dart'
    as _i83;
import '../../src/guards/activity/presentation/staffs/bloc/staff_activity_bloc.dart'
    as _i82;
import '../../src/guards/activity/presentation/staffs/controllers/add.staff.attendance.controller.dart'
    as _i84;
import '../../src/guards/activity/presentation/staffs/controllers/edit.staff.attendance.controller.dart'
    as _i90;
import '../../src/guards/patroll/data/datasources/patroll.local.data.source.dart'
    as _i18;
import '../../src/guards/patroll/data/datasources/patroll.remote.data.source.dart'
    as _i19;
import '../../src/guards/patroll/data/repositories/patroll.repository.dart'
    as _i30;
import '../../src/guards/patroll/domain/repositories/i.patroll.repository.dart'
    as _i29;
import '../../src/guards/patroll/domain/usecases/add.patroll.usecase.dart'
    as _i44;
import '../../src/guards/patroll/domain/usecases/delete.patroll.usecase.dart'
    as _i49;
import '../../src/guards/patroll/domain/usecases/edit.patroll.usecase.dart'
    as _i52;
import '../../src/guards/patroll/domain/usecases/list.local.patroll.usecase.dart'
    as _i34;
import '../../src/guards/patroll/domain/usecases/list.patroll.usecase.dart'
    as _i33;
import '../../src/guards/patroll/presentation/patrolls_list/bloc/patroll_bloc.dart'
    as _i79;
import '../../src/guards/patroll/presentation/scan_patrolls/controller/scan.patroll.controller.dart'
    as _i81;
import '../../src/residents/visitors/data/datasources/complaint/complaint.local.datasource.dart'
    as _i10;
import '../../src/residents/visitors/data/datasources/complaint/complaint.remote.datasource.dart'
    as _i11;
import '../../src/residents/visitors/data/datasources/visitor.local.datasource.dart'
    as _i21;
import '../../src/residents/visitors/data/datasources/visitor.remote.datasource.dart'
    as _i22;
import '../../src/residents/visitors/data/repositories/complaint.repository.dart'
    as _i28;
import '../../src/residents/visitors/data/repositories/visitor.repository.dart'
    as _i32;
import '../../src/residents/visitors/domain/entities/complaint.entity.dart'
    as _i14;
import '../../src/residents/visitors/domain/repositories/i.complaint.repository.dart'
    as _i27;
import '../../src/residents/visitors/domain/repositories/i.visitors.repository.dart'
    as _i31;
import '../../src/residents/visitors/domain/usecases/add.visitor.activity.usecase.dart'
    as _i46;
import '../../src/residents/visitors/domain/usecases/edit.visitors.usecase.dart'
    as _i54;
import '../../src/residents/visitors/domain/usecases/get.local.visitors.usecase.dart'
    as _i67;
import '../../src/residents/visitors/domain/usecases/get.visitor.activities.usecase.dart'
    as _i74;
import '../../src/residents/visitors/domain/usecases/helpdesk/add.comments.usecase.dart'
    as _i41;
import '../../src/residents/visitors/domain/usecases/helpdesk/add.complaint.usecase.dart'
    as _i42;
import '../../src/residents/visitors/domain/usecases/helpdesk/edit.complaint.usecase.dart'
    as _i50;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.comment.votes.usecase.dart'
    as _i56;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.comments.usecase.dart'
    as _i57;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.comments.vote.usecase.dart'
    as _i58;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.complaint.categories.usecase.dart'
    as _i59;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.complaint.usecase.dart'
    as _i60;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.complaint.votes.usecase%20copy.dart'
    as _i61;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.complaints.usecase.dart'
    as _i62;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.complaints.vote.usecase.dart'
    as _i63;
import '../../src/residents/visitors/domain/usecases/helpdesk/get.my.complaint.usecase.dart'
    as _i68;
import '../../src/residents/visitors/domain/usecases/helpdesk/upload.complaint.image.dart'
    as _i37;
import '../../src/residents/visitors/domain/usecases/helpdesk/vote.complaint.usecase.dart'
    as _i40;
import '../../src/residents/visitors/presentation/helpdesk/controller/comment.controller.dart'
    as _i87;
import '../../src/residents/visitors/presentation/helpdesk/controller/complaint.controller.dart'
    as _i88;
import '../../src/residents/visitors/presentation/helpdesk/controller/edit.complaint.controller.dart'
    as _i89;
import '../../src/residents/visitors/presentation/helpdesk/controller/help.desk.controller.dart'
    as _i76;
import '../../src/residents/visitors/presentation/helpdesk/controller/my.complaint.controller.dart'
    as _i77;
import '../../src/residents/visitors/presentation/helpdesk/controller/my.reactions.controller.dart'
    as _i78;
import '../../src/residents/visitors/presentation/helpdesk/controller/raise.complaint.controller.dart'
    as _i80;
import '../../src/residents/visitors/presentation/helpdesk/page/edit.compliant.page.dart'
    as _i12;
import '../../src/residents/visitors/presentation/helpdesk/page/my.complaints.page.dart'
    as _i17;
import '../../src/residents/visitors/presentation/helpdesk/page/raise.compliant.page.dart'
    as _i20;
import '../../src/residents/visitors/presentation/visitors/controller/add.visitor.activity.controller.dart'
    as _i85;
import '../../src/residents/visitors/presentation/visitors/controller/get.visitor.activities.controller.dart'
    as _i91;

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
    gh.lazySingleton<_i10.ComplaintLocalDatasource>(() =>
        _i10.ComplaintLocalDatasource(cache: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i11.ComplaintRemoteDatasource>(
        () => _i11.ComplaintRemoteDatasource(client: gh<_i7.Client>()));
    gh.factory<_i12.EditComplaintPage>(() => _i12.EditComplaintPage(
          key: gh<_i13.Key>(),
          item: gh<_i14.ComplaintEntity>(),
        ));
    gh.singleton<_i15.INetworkInfo>(
        _i15.NetworkInfoImp(connectionChecker: gh<_i16.InternetConnection>()));
    gh.factory<_i17.MyComplaintsPage>(
        () => _i17.MyComplaintsPage(key: gh<_i13.Key>()));
    gh.singleton<_i18.PatrollLocalDataSource>(
        _i18.PatrollLocalDataSource(cache: gh<_i5.SharedPreferences>()));
    gh.singleton<_i19.PatrollRemoteDataSource>(
        _i19.PatrollRemoteDataSource(client: gh<_i7.Client>()));
    gh.factory<_i20.RaiseCompliantPage>(
        () => _i20.RaiseCompliantPage(key: gh<_i13.Key>()));
    gh.lazySingleton<_i21.VisitorLocalDatasource>(
        () => _i21.VisitorLocalDatasource(cache: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i22.VisitorRemoteDatasource>(
        () => _i22.VisitorRemoteDatasource(client: gh<_i7.Client>()));
    gh.singleton<_i23.IActivityRepository>(_i24.ActivityRepository(
      networkInfo: gh<_i15.INetworkInfo>(),
      remoteDataSource: gh<_i6.ActivityRemoteDatasource>(),
      localDataSource: gh<_i4.ActivityLocalDatasource>(),
    ));
    gh.singleton<_i25.IAuthRepository>(_i26.AuthRepository(
      networkInfo: gh<_i15.INetworkInfo>(),
      authRemoteDataSource: gh<_i9.AuthRemoteDataSource>(),
      authLocalDataSource: gh<_i8.AuthLocalDataSource>(),
    ));
    gh.lazySingleton<_i27.IComplaintRepository>(() => _i28.ComplaintRepository(
          networkInfo: gh<_i15.INetworkInfo>(),
          remoteDataSource: gh<_i11.ComplaintRemoteDatasource>(),
          localDataSource: gh<_i10.ComplaintLocalDatasource>(),
        ));
    gh.singleton<_i29.IPatrollRepository>(_i30.PatrollRepository(
      networkInfo: gh<_i15.INetworkInfo>(),
      remoteDataSource: gh<_i19.PatrollRemoteDataSource>(),
      localDataSource: gh<_i18.PatrollLocalDataSource>(),
    ));
    gh.lazySingleton<_i31.IVisitorsRepository>(() => _i32.VisitorRepository(
          networkInfo: gh<_i15.INetworkInfo>(),
          remoteDataSource: gh<_i22.VisitorRemoteDatasource>(),
          localDataSource: gh<_i21.VisitorLocalDatasource>(),
        ));
    gh.singleton<_i33.ListPatrollUseCase>(_i33.ListPatrollUseCase(
        patrollRepository: gh<_i29.IPatrollRepository>()));
    gh.singleton<_i34.ListPatrollUseCase>(_i34.ListPatrollUseCase(
        patrollRepository: gh<_i29.IPatrollRepository>()));
    gh.singleton<_i35.ResendPhoneConfirmationCode>(
        _i35.ResendPhoneConfirmationCode(
            signInRepository: gh<_i25.IAuthRepository>()));
    gh.singleton<_i36.SignOut>(
        _i36.SignOut(signInRepository: gh<_i25.IAuthRepository>()));
    gh.singleton<_i37.UploadComplaintImageUseCase>(
        _i37.UploadComplaintImageUseCase(
            repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i38.UploadFileUseCase>(
        _i38.UploadFileUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i39.VerifyPhoneNumber>(
        _i39.VerifyPhoneNumber(signInRepository: gh<_i25.IAuthRepository>()));
    gh.singleton<_i40.VoteComplaintUseCase>(
        _i40.VoteComplaintUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i41.AddCommentUseCase>(
        _i41.AddCommentUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i42.AddComplaintUseCase>(
        _i42.AddComplaintUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i43.AddGuestActivityUseCase>(
        _i43.AddGuestActivityUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i44.AddPatrollUseCase>(_i44.AddPatrollUseCase(
        patrollRepository: gh<_i29.IPatrollRepository>()));
    gh.singleton<_i45.AddStaffAttendanceUseCase>(
        _i45.AddStaffAttendanceUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i46.AddVisitorActivityUseCase>(
        _i46.AddVisitorActivityUseCase(repo: gh<_i31.IVisitorsRepository>()));
    gh.singleton<_i47.CheckVisitorPasscodeUseCase>(
        _i47.CheckVisitorPasscodeUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i48.ConfirmPhoneConfirmationCode>(
        _i48.ConfirmPhoneConfirmationCode(
            signInRepository: gh<_i25.IAuthRepository>()));
    gh.singleton<_i49.DeletePatrollUseCase>(_i49.DeletePatrollUseCase(
        patrollRepository: gh<_i29.IPatrollRepository>()));
    gh.singleton<_i50.EditComplaintUseCase>(
        _i50.EditComplaintUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i51.EditGuestActivityUseCase>(
        _i51.EditGuestActivityUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i52.EditPatrollUseCase>(_i52.EditPatrollUseCase(
        patrollRepository: gh<_i29.IPatrollRepository>()));
    gh.singleton<_i53.EditStaffAttendanceUseCase>(
        _i53.EditStaffAttendanceUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i54.EditVisitorActivityUseCase>(
        _i54.EditVisitorActivityUseCase(repo: gh<_i31.IVisitorsRepository>()));
    gh.singleton<_i55.GetActivityTypesUseCase>(
        _i55.GetActivityTypesUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i56.GetCommentVotesUseCase>(
        _i56.GetCommentVotesUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i57.GetCommentsUseCase>(
        _i57.GetCommentsUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i58.GetCommentsVoteUseCase>(
        _i58.GetCommentsVoteUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i59.GetComplaintCategoriesUseCase>(
        _i59.GetComplaintCategoriesUseCase(
            repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i60.GetComplaintUseCase>(
        _i60.GetComplaintUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i61.GetComplaintVotesUseCase>(
        _i61.GetComplaintVotesUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i62.GetComplaintsUseCase>(
        _i62.GetComplaintsUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i63.GetComplaintsVoteUseCase>(
        _i63.GetComplaintsVoteUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i64.GetGuestsActivitiesUseCase>(
        _i64.GetGuestsActivitiesUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i65.GetGuestsActivitiesUseCase>(
        _i65.GetGuestsActivitiesUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i66.GetGuestsUseCase>(
        _i66.GetGuestsUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.lazySingleton<_i67.GetLocalVisitorActivitiesUseCase>(() =>
        _i67.GetLocalVisitorActivitiesUseCase(
            repo: gh<_i31.IVisitorsRepository>()));
    gh.singleton<_i68.GetMyComplaintsUseCase>(
        _i68.GetMyComplaintsUseCase(repo: gh<_i27.IComplaintRepository>()));
    gh.singleton<_i69.GetResidentsUseCase>(
        _i69.GetResidentsUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i70.GetStaffsActivityUseCase>(
        _i70.GetStaffsActivityUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i71.GetStaffsActivityUseCase>(
        _i71.GetStaffsActivityUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i72.GetStaffsUseCase>(
        _i72.GetStaffsUseCase(repo: gh<_i23.IActivityRepository>()));
    gh.singleton<_i73.GetToken>(
        _i73.GetToken(authRepository: gh<_i25.IAuthRepository>()));
    gh.singleton<_i74.GetVisitorsActivitiesUseCase>(
        _i74.GetVisitorsActivitiesUseCase(
            repo: gh<_i31.IVisitorsRepository>()));
    gh.factory<_i75.GuestActivityBloc>(
        () => _i75.GuestActivityBloc(gh<_i65.GetGuestsActivitiesUseCase>()));
    gh.factory<_i76.HelpDeskController>(() => _i76.HelpDeskController(
          gh<_i59.GetComplaintCategoriesUseCase>(),
          gh<_i62.GetComplaintsUseCase>(),
        ));
    gh.factory<_i77.MyComplaintController>(
        () => _i77.MyComplaintController(gh<_i68.GetMyComplaintsUseCase>()));
    gh.factory<_i78.MyReactionController>(
        () => _i78.MyReactionController(gh<_i63.GetComplaintsVoteUseCase>()));
    gh.factory<_i79.PatrollBloc>(() => _i79.PatrollBloc(
          gh<_i44.AddPatrollUseCase>(),
          gh<_i52.EditPatrollUseCase>(),
          gh<_i33.ListPatrollUseCase>(),
          gh<_i49.DeletePatrollUseCase>(),
        ));
    gh.factory<_i80.RaiseComplaintController>(
        () => _i80.RaiseComplaintController(
              gh<_i42.AddComplaintUseCase>(),
              gh<_i59.GetComplaintCategoriesUseCase>(),
              gh<_i37.UploadComplaintImageUseCase>(),
            ));
    gh.factory<_i81.ScanPatrollController>(() =>
        _i81.ScanPatrollController(useCase: gh<_i44.AddPatrollUseCase>()));
    gh.factory<_i82.StaffActivityBloc>(
        () => _i82.StaffActivityBloc(gh<_i71.GetStaffsActivityUseCase>()));
    gh.singleton<_i83.AddGuestActivityController>(
        _i83.AddGuestActivityController(
      getResidentsUseCase: gh<_i69.GetResidentsUseCase>(),
      uploadFileUseCase: gh<_i38.UploadFileUseCase>(),
      getActivityTypesUseCase: gh<_i55.GetActivityTypesUseCase>(),
      getStaffsUseCase: gh<_i72.GetStaffsUseCase>(),
      getGuestsUseCase: gh<_i66.GetGuestsUseCase>(),
      addGuestActivityUseCase: gh<_i43.AddGuestActivityUseCase>(),
      editGuestActivityUseCase: gh<_i51.EditGuestActivityUseCase>(),
      checkVisitorPasscodeUseCase: gh<_i47.CheckVisitorPasscodeUseCase>(),
    ));
    gh.factory<_i84.AddStaffAttendanceController>(
        () => _i84.AddStaffAttendanceController(
              addStaffAttendanceUseCase: gh<_i45.AddStaffAttendanceUseCase>(),
              getStaffsUseCase: gh<_i72.GetStaffsUseCase>(),
            ));
    gh.singleton<_i85.AddVisitorActivityController>(
        _i85.AddVisitorActivityController(
      getResidentsUseCase: gh<_i69.GetResidentsUseCase>(),
      getActivityTypesUseCase: gh<_i55.GetActivityTypesUseCase>(),
      getStaffsUseCase: gh<_i72.GetStaffsUseCase>(),
      getGuestsUseCase: gh<_i66.GetGuestsUseCase>(),
      addVisitorActivityUseCase: gh<_i46.AddVisitorActivityUseCase>(),
    ));
    gh.factory<_i86.AuthStateBloc>(() => _i86.AuthStateBloc(
          verifyPhoneNumber: gh<_i39.VerifyPhoneNumber>(),
          getToken: gh<_i73.GetToken>(),
          resendPhoneConfirmationCode: gh<_i35.ResendPhoneConfirmationCode>(),
          signOut: gh<_i36.SignOut>(),
          confirmPhoneConfirmationCode: gh<_i48.ConfirmPhoneConfirmationCode>(),
        ));
    gh.factory<_i87.CommentController>(() => _i87.CommentController(
          gh<_i57.GetCommentsUseCase>(),
          gh<_i41.AddCommentUseCase>(),
        ));
    gh.factory<_i88.ComplaintController>(() => _i88.ComplaintController(
          gh<_i60.GetComplaintUseCase>(),
          gh<_i50.EditComplaintUseCase>(),
        ));
    gh.factory<_i89.EditComplaintController>(() => _i89.EditComplaintController(
          gh<_i50.EditComplaintUseCase>(),
          gh<_i59.GetComplaintCategoriesUseCase>(),
          gh<_i37.UploadComplaintImageUseCase>(),
          gh<_i60.GetComplaintUseCase>(),
        ));
    gh.factory<_i90.EditStaffAttendanceController>(() =>
        _i90.EditStaffAttendanceController(
            editStaffAttendanceUseCase: gh<_i53.EditStaffAttendanceUseCase>()));
    gh.factory<_i91.GetVisitorActivitiesController>(() =>
        _i91.GetVisitorActivitiesController(
            gh<_i74.GetVisitorsActivitiesUseCase>()));
    return this;
  }
}
