import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/widgets/app.snackbar.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/resident.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/add.guest.activity.usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/get.activity.types.usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/get.guests.usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/get.residents.usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/get.staffs.usecase.dart';

import '../../../../../core/errors/exceptions.dart';

@singleton
class AddActivityController extends GetxController {
  final GetActivityTypesUseCase getActivityTypesUseCase;
  final GetStaffsUseCase getStaffsUseCase;
  final GetGuestsUseCase getGuestsUseCase;
  final AddGuestActivityUseCase addGuestActivityUseCase;
  final GetResidentsUseCase getResidentsUseCase;
  Rx<String> type = Rx<String>('');
  int activeStep = 0.obs();

  AddActivityController({
    required this.getResidentsUseCase,
    required this.getActivityTypesUseCase,
    required this.getStaffsUseCase,
    required this.getGuestsUseCase,
    required this.addGuestActivityUseCase,
  });

  void initialize() async {
    activityUser.value = const UserEntity(name: '', phoneNumber: '', uid: '');
    getStaffMembers();
    getActivityTypes();
    getPrevGuests();
    getResidents();
  }

  int pageLimit = 25;
  late Rx<UserEntity> activityUser =
      Rx<UserEntity>(const UserEntity(name: '', phoneNumber: '', uid: ''));

  late Rx<ActivityEntity> activity = Rx<ActivityEntity>(ActivityEntity());

  // loading status holder variables
  RxBool adding = false.obs;
  RxBool loadingStaffs = false.obs;
  RxBool loadingResidents = false.obs;
  RxBool loadingActivityTypes = false.obs;
  RxBool loadingGuests = false.obs;
  RxBool saving = false.obs;

  Rx<DateTime> entry = Rx<DateTime>(DateTime.now());
  Rx<DateTime> exit = Rx<DateTime>(DateTime.now());

  //data holder
  Rx<List<UserEntity>> staffs = Rx<List<UserEntity>>([]);
  Rx<List<UserEntity>> guests = Rx<List<UserEntity>>([]);
  Rx<List<ResidentEntity>> residents = Rx<List<ResidentEntity>>([]);
  Rx<List<ActivityTypeEntity>> activityTypes = Rx<List<ActivityTypeEntity>>([]);
  //error holder variable

  Rx<Failure?> guestsError = Rx<Failure?>(null);
  Rx<Failure?> residentsError = Rx<Failure?>(null);
  Rx<Failure?> staffsError = Rx<Failure?>(null);
  Rx<Failure?> error = Rx<Failure?>(null);
  Rx<Failure?> activityTypesError = Rx<Failure?>(null);

  //adding
  Future save(BuildContext context) async {
    saving.value = true;
    saving.refresh();

    final result = await addGuestActivityUseCase(AddGuestActivityParam(
        activity: activity.value, entry: entry.value, exit: exit.value));
    if (result == null) {
      error.value = Failure(message: UnExpectedFailure().message);
      saving.value = false;
      saving.refresh();
      error.refresh();
    }
    result?.fold((l) {
      error.value = l;
      saving.value = false;
      saving.refresh();
      error.refresh();
      AppSnackBar.failure(
          failure: l,
          position: SnackPosition.TOP,
          duration: const Duration(seconds: 10));
    }, (r) async {
      saving.value = false;
      saving.refresh();
      activity.value = r;
      AppSnackBar.success(
          title: 'Successful', message: 'Guest Activity Added Succesfully!');
      Navigator.maybePop(context, r);
    });
  }

  //adding
  Future getStaffMembers({String? search, int? page, int? limit}) async {
    if ((page ?? 0) <= 1) {
      loadingStaffs.value = true;
      loadingStaffs.refresh();
    }
    final result = await getStaffsUseCase(
        GetStaffsParam(page: page, limit: limit ?? pageLimit, search: search));
    if (result == null) {
      staffsError.value = Failure(message: UnExpectedFailure().message);
      loadingStaffs.value = false;
      staffsError.refresh();
      loadingStaffs.refresh();
    }
    result?.fold((l) {
      staffsError.value = l;
      loadingStaffs.value = false;
      loadingStaffs.refresh();
      staffsError.refresh();
    }, (r) async {
      if (r.results.isEmpty) {
        staffsError.value = NoDataFailure(message: NoDataException().message);
        loadingStaffs.value = false;
        loadingStaffs.refresh();
        staffsError.refresh();
        return;
      }
      if ((page ?? 0) < 1) {
        staffs.value.clear();
      }
      loadingStaffs.value = false;
      loadingStaffs.refresh();
      staffs.refresh();
      staffs.value.addAll(r.results);
    });
  }

  //prev guests
  Future getPrevGuests({String? search, int? limit, int? page}) async {
    if ((page ?? 0) <= 1) {
      loadingGuests.value = true;
      loadingGuests.refresh();
    }
    final result = await getGuestsUseCase(
        GetGuestsParam(page: page, limit: limit ?? pageLimit, search: search));
    if (result == null) {
      guestsError.value = Failure(message: UnExpectedFailure().message);
      loadingGuests.value = false;
      loadingGuests.refresh();
      guestsError.refresh();
    }
    result?.fold((l) {
      guestsError.value = l;
      loadingGuests.value = false;
      loadingGuests.refresh();
      guestsError.refresh();
    }, (r) async {
      if (r.isEmpty) {
        guestsError.value = NoDataFailure(message: NoDataException().message);
        loadingGuests.value = false;
        loadingGuests.refresh();
        guestsError.refresh();
        return;
      }
      if ((page ?? 0) <= 1) {
        guests.value.clear();
      }
      loadingGuests.value = false;
      loadingGuests.refresh();

      guests.value.addAll(r);
      guests.refresh();
    });
  }

  //activity types
  Future getActivityTypes({String? search, int? limit, int? page}) async {
    if ((page ?? 0) <= 1) {
      loadingActivityTypes.value = true;
      loadingActivityTypes.refresh();
    }
    final result = await getActivityTypesUseCase(GetActivityTypeParam(
        page: page, limit: limit ?? pageLimit, search: search));
    if (result == null) {
      guestsError.value = Failure(message: UnExpectedFailure().message);
      loadingActivityTypes.value = false;
      loadingActivityTypes.refresh();
      guestsError.refresh();
    }
    result?.fold((l) {
      guestsError.value = l;
      guestsError.refresh();
    }, (r) async {
      if (r.isEmpty) {
        guestsError.value = NoDataFailure(message: NoDataException().message);
        loadingActivityTypes.value = false;

        loadingActivityTypes.refresh();
        guestsError.refresh();
        return;
      }
      if ((page ?? 0) <= 1) {
        activityTypes.value.clear();
      }
      activityTypes.value.addAll(r);
      activityTypes.refresh();
      loadingActivityTypes.value = false;
      loadingActivityTypes.refresh();
    });
  }

  //activity types
  Future getResidents({String? search, int? limit, int? page}) async {
    if ((page ?? 0) <= 1) {
      loadingResidents.value = true;
      loadingResidents.refresh();
    }
    final result = await getResidentsUseCase(GetResidentsParam(
        page: page, limit: limit ?? pageLimit, search: search));
    if (result == null) {
      residentsError.value = Failure(message: UnExpectedFailure().message);
      loadingResidents.value = false;
      loadingResidents.refresh();
      residentsError.refresh();
    }
    result?.fold((l) {
      residentsError.value = l;
      residentsError.refresh();
    }, (r) async {
      if (r.results.isEmpty) {
        residentsError.value =
            NoDataFailure(message: NoDataException().message);
        loadingResidents.value = false;

        loadingResidents.refresh();
        residentsError.refresh();
        return;
      }
      if ((page ?? 0) < 1) {
        residents.value.clear();
      }
      residents.value.addAll(r.results);
      residents.refresh();
      loadingResidents.value = false;
      loadingResidents.refresh();
    });
  }

  void init() {
    activeStep = 0;
    activity = Rx<ActivityEntity>(ActivityEntity());
    refresh();
  }

  bool canGoToStep3() {
    if (activity.value.field_guest_type?.toLowerCase().contains('cab') ??
        false) {
      return activity.value.field_short_notes != null &&
          activity.value.field_ref_apartment_unit != null;
    } else {
      return activity.value.field_short_notes != null;
    }
  }
}
