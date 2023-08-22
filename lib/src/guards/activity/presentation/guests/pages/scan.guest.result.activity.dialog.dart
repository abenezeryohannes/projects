import 'package:flutter/material.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/domain/entities/activity.entity.dart';
import 'package:rnginfra/src/core/domain/entities/guest.activity.entity.dart';
import 'package:rnginfra/src/core/domain/entities/guest.visitation.entity.dart';
import 'package:rnginfra/src/core/errors/exceptions.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/widgets/app.snackbar.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
import 'package:rnginfra/src/core/widgets/show.error.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/file.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/edit.guest.activity.usecase.dart';
import 'package:rnginfra/src/guards/activity/domain/usecases/upload.file.usecase.dart';

import '../../../../../core/widgets/big.text.button.dart';
import '../../../../../core/widgets/image.form.dart';
import '../../../../../core/widgets/text.input.form.dart';

class ScanGuestResultActivity extends StatefulWidget {
  const ScanGuestResultActivity(
      {super.key, required this.activity, this.failure});
  final GuestVisitationEntity? activity;
  final Failure? failure;
  @override
  State<ScanGuestResultActivity> createState() =>
      _ScanGuestResultActivityState();
}

PageController controller = PageController();

class _ScanGuestResultActivityState extends State<ScanGuestResultActivity> {
  String? file;
  String? driverIdentification;
  bool showFinal = false;
  bool loading = false;

  @override
  void initState() {
    showFinal = !(widget.activity != null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: Colors.transparent,
            child: Container(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * (10 / 12)),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: ShowAppropriet())));
  }

  Widget ShowAppropriet() {
    if (!showFinal) {
      return _whenCab();
    } else {
      return finalResult();
    }
  }

  uploadImage() async {
    if (file != null && file!.trim().isNotEmpty) {
      load(true);
      final result =
          await getIt<UploadFileUseCase>()(UploadFileParam(file: file!));
      if (result == null) {
        AppSnackBar.failure(
            failure: Failure(message: UnExpectedException().message));
        load(false);
      } else {
        result.fold((l) {
          AppSnackBar.failure(failure: l);
          load(false);
        }, (r) async {
          // AppSnackBar.success(
          //     title: 'success',
          //     message:
          //         'file uploaded now change the activity for post and add image and number to it then edit then show final widget!');
          await save(r);
        });
      }
    } else {
      if (driverIdentification != null) {
        load(true);
        await save(null);
      } else {
        AppSnackBar.failure(failure: Failure(message: 'Nothing to add!'));
      }
    }
  }

  load(bool isLoading) {
    setState(() {
      loading = isLoading;
    });
  }

  save(FileEntity? file) async {
    //
    ActivityEntity? activityEntity = widget.activity?.toRequestActivity();
    if (activityEntity == null) {
      return;
    }
    if (file != null) {
      activityEntity.field_guest_image = file.fid;
    }
    activityEntity.field_vehicle_identification = driverIdentification;
//
    final secondResult = await getIt<EditGuestActivityUseCase>()(
        EditGuestActivityParam(
            targetId: widget.activity?.id ?? '',
            activity: activityEntity,
            entranceTime: null,
            exitTime: null));
    //
    if (secondResult == null) {
      AppSnackBar.failure(
          failure: Failure(message: UnExpectedException().message));
      load(false);
    } else {
      secondResult.fold((l) {
        AppSnackBar.failure(failure: l);
        load(false);
      }, (r) {
        load(false);
        setState(() {
          showFinal = true;
        });
      });
    }
  }

  Widget _whenCab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20.0),
            child: LoadingBar(),
          ),
        if (widget.activity != null)
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10.0),
            child: ImageForm(
              // image:
              width: 120,
              height: 120,
              radius: 500,
              editable: true,
              isLoading: (val) {
                load(val);
              },
              localImage: file,
              iconSize: 32,
              onUpload: (String localImage) async {
                setState(() {
                  file = localImage;
                });
              },
              onSave: () async {
                uploadImage();
              },
            ),
          ),
        if (widget.activity != null)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Guest Image',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

        if (widget.activity != null &&
            (widget.activity?.guest_type?.toLowerCase().contains('cab') ??
                false))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: TextInputForm(
              radius: 10,
              elevation: 0,
              fillColor: Colors.transparent,
              focusedBorderColor: Theme.of(context).colorScheme.secondary,
              focusedBorderWidth: 2,
              validator: (val) => (val?.length ?? 0) < 4
                  ? 'Must be at least 3 characters!'
                  : null,
              onChanged: (String val) {
                setState(() {
                  driverIdentification = val;
                });
              },
              placeholder: 'Vehicle Identification Number',
            ),
          ),

        //
        //

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 10, bottom: 20),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      showFinal = true;
                    });
                  },
                  child: Text(
                    'Skip',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).disabledColor),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 20, bottom: 20),
              child: TextButton(
                  onPressed: () {
                    uploadImage();
                  },
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  )),
            ),
          ],
        )
      ],
    );
  }

  Widget finalResult() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20.0, bottom: 20, left: 20, right: 20),
          child: Text(
            (widget.activity != null) ? 'Access Granted' : 'Access Not Granted',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        if (widget.failure != null)
          SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ShowError(
                    failure: Failure(message: 'This is the Error message')),
              )),
        if (widget.failure != null)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              width: 200,
              child: BigTextButton(
                textColor: Theme.of(context).colorScheme.onBackground,
                borderColor: Theme.of(context).cardColor,
                backgroudColor: Theme.of(context).cardColor,
                horizontalMargin: const EdgeInsets.symmetric(horizontal: 30),
                onClick: () {
                  Navigator.maybePop<String>(context, 'Retry');
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                text: 'Retry',
              ),
            ),
          ),
        if (widget.activity != null)
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 20, left: 20, right: 20),
            child: Text(
              widget.activity?.residents ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        if (widget.activity != null)
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10, left: 20, right: 20),
            child: Text(
              widget.activity?.short_notes ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        if (widget.activity != null)
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 40, left: 20, right: 20),
            child: Text(
              widget.activity?.long_notes ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        if (widget.activity != null)
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 30),
            child: SizedBox(
              width: 200,
              child: BigTextButton(
                textColor: Theme.of(context).colorScheme.onBackground,
                borderColor: Theme.of(context).cardColor,
                backgroudColor: Theme.of(context).cardColor,
                horizontalMargin: const EdgeInsets.symmetric(horizontal: 30),
                onClick: () {
                  Navigator.maybePop<String>(context, 'Ok');
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                text: 'Ok',
              ),
            ),
          ),
      ],
    );
  }
}
