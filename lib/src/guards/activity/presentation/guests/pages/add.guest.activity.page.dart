import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
import 'package:rnginfra/src/core/widgets/text.input.form.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/resident.entity.dart';
import 'package:rnginfra/src/guards/activity/presentation/guests/controller/add.activity.controller.dart';
import 'package:rnginfra/src/guards/core/widgets/time.picker.dart';
import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/widgets/autocomplete.text.form.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  late AddActivityController controller;

  @override
  void initState() {
    controller = getIt<AddActivityController>();
    controller.init();
    controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Hero(
      tag: 'GUEST_ACTIVITY',
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => (controller.saving.value)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: LoadingBar(
                        color: Theme.of(context).colorScheme.secondary,
                        backColor: Theme.of(context).cardColor,
                      ),
                    )
                  : const SizedBox()),
              const SizedBox(
                height: 20,
              ),
              Obx(() => Stepper(
                      currentStep: controller.activeStep,
                      onStepTapped: (value) {
                        setState(() {
                          if (value < controller.activeStep) {
                            controller.activeStep = value;
                          }
                        });
                      },
                      controlsBuilder: (context, details) => const SizedBox(),
                      steps: [
                        Step(
                            isActive: controller.activeStep == 0,
                            label: null,
                            title: Text(
                              'Choose Guest Type',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            content: activityTypeForm()),
                        Step(
                            isActive: controller.activeStep == 1,
                            title: Text(
                              'Select Resident',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            content: _selectResident()),
                        Step(
                            isActive: controller.activeStep == 2,
                            title: Text(
                              'Set Guest Info',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            content: userForm()),
                        // Step(
                        //     isActive: controller.activeStep == 2,
                        //     title: Text(
                        //       'Set Time',
                        //       style: Theme.of(context).textTheme.titleSmall,
                        //     ),
                        //     content: validatorForm()),
                      ])),
              // Expanded(
              //     child: Padding(
              //   padding: const EdgeInsets.only(top: 0.0, left: 40, right: 40),
              //   child: manageStepper(),
              // )),
            ],
          ),
        ),
      ),
    );
  }

  Widget manageStepper() {
    switch (controller.activeStep) {
      case 0:
        return activityTypeForm();
      case 1:
        return userForm();
      case 2:
        return validatorForm();
      default:
        return activityTypeForm();
    }
  }

  Widget userForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.activity.value.field_guest_type
                    ?.toLowerCase()
                    .contains('cab') ??
                false)
              SizedBox(
                width: MediaQuery.of(context).size.width * (10 / 12),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: TextInputForm(
                    radius: 10,
                    elevation: 0,
                    fillColor: Colors.transparent,
                    focusedBorderColor: Theme.of(context).colorScheme.secondary,
                    focusedBorderWidth: 2,
                    initialValue:
                        controller.activity.value.field_vehicle_identification,
                    validator: (val) => (val?.length ?? 0) < 4
                        ? 'Must be at least 4 characters!'
                        : null,
                    onChanged: (String val) {
                      setState(() {
                        controller.activity.value.field_vehicle_identification =
                            val;
                        controller.canGoToStep3.value = val.isNotEmpty;
                      });
                    },
                    placeholder: 'Vehicle Identification',
                  ),
                ),
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width * (10 / 12),
              child: Padding(
                padding: EdgeInsets.only(
                    top: (controller.activity.value.field_guest_type
                                ?.toLowerCase()
                                .contains('cab') ??
                            false)
                        ? 20
                        : 0),
                child: TextInputForm(
                  radius: 10,
                  elevation: 0,
                  fillColor: Colors.transparent,
                  focusedBorderColor: Theme.of(context).colorScheme.secondary,
                  focusedBorderWidth: 2,
                  initialValue: controller.activity.value.field_short_notes,
                  validator: (val) => (val?.length ?? 0) < 4
                      ? 'Must be at least 3 characters!'
                      : null,
                  onChanged: (String val) {
                    setState(() {
                      controller.activity.value.field_short_notes = val;
                    });
                  },
                  placeholder: 'Short Note',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * (10 / 12),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextInputForm(
                  radius: 10,
                  elevation: 0,
                  minLines: 5,
                  maxLines: 10,
                  fillColor: Colors.transparent,
                  focusedBorderColor: Theme.of(context).colorScheme.secondary,
                  focusedBorderWidth: 2,
                  initialValue: controller.activity.value.field_long_notes,
                  validator: (val) => (val?.length ?? 0) < 4
                      ? 'Must be at least 4 characters!'
                      : null,
                  onChanged: (String val) {
                    setState(() {
                      controller.activity.value.field_long_notes = val;
                    });
                  },
                  placeholder: 'Long Note',
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: controller.canGoToStep3.value ? 1 : 0,
            child: TextButton(
                onPressed: () {
                  controller.save(context);
                  // if (controller.canGoToStep3.value) {
                  //   setState(() {
                  //     controller.activeStep += 1;
                  //   });
                  // }
                },
                child: Text(
                  'Add',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                )),
          ),
        )
      ],
    );
  }
//

  Widget _selectResident() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: AutoCompleteTextForm(
                radius: 20,
                elevation: 1,
                rightMargin: MediaQuery.of(context).size.width * (5 / 12),
                validator: (val) => (val?.length ?? 0) < 4
                    ? 'Must be at least 4 characters!'
                    : null,
                // initialValue: controller.activity.value.field_ref_apartment_unit,
                onChanged: (String val) {
                  setState(() {
                    controller.activity.value.field_ref_apartment_unit = null;
                  });
                  controller.getResidents(search: val);
                },
                fillColor: Colors.transparent,
                placeholder: 'Resident Number',
                onSelected: (String selected) {
                  ResidentEntity? entity = controller.residents.value
                      .firstWhereOrNull((element) =>
                          element.name
                              ?.toLowerCase()
                              .contains(selected.toLowerCase()) ??
                          false);
                  if (entity == null) return;
                  setState(() {
                    controller.activity.value.field_ref_apartment_unit =
                        int.parse(entity.unit_number!);
                  });
                },
                enabled: true,
                suggestions: controller.residents.value,
                suggestionPropertyToShow: 'name',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity:
                    controller.activity.value.field_ref_apartment_unit != null
                        ? 1
                        : 0,
                child: TextButton(
                    onPressed: () {
                      if (controller.activity.value.field_ref_apartment_unit !=
                          null) {
                        setState(() {
                          controller.activeStep += 1;
                        });
                      }
                    },
                    child: Text(
                      'Continue',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )),
              ),
            )
          ],
        ));
  }

  Widget activityTypeForm() {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 230,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(0),
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                childAspectRatio: 1,
                children: controller.activityTypes.value.map((e) {
                  return _activityTypeCard(e);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 00,
            ),
          ],
        ));
  }

//
  Widget validatorForm() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 20.0, left: 0, right: 20),
                child: Text(
                  'Please select Guest entry and exit time!',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
              ),
              CustomeTimePicker(
                  time: controller.entry.value,
                  icon: Image.asset(
                    'assets/icon/enter.png',
                    width: 32,
                    height: 32,
                  ),
                  title: 'Entry Time',
                  onChange: (date) {
                    setState(() {
                      controller.entry.value = date;
                    });
                  })
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: controller.canGoToStep3.value ? 1 : 0,
              child: TextButton(
                  onPressed: () {
                    controller.save(context);
                  },
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _activityTypeCard(ActivityTypeEntity entity) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              controller.activity.value.field_guest_type =
                  entity.name.toLowerCase();
              controller.activity.refresh();
              controller.activeStep += 1;
            });
          },
          child: Container(
            width: 90,
            height: 70,
            decoration: BoxDecoration(
                color: (controller.activity.value.field_guest_type
                            ?.endsWith(entity.name.toLowerCase()) ??
                        false)
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Image.asset(
                entity.icon ?? 'assets/icon/calendar.png',
                width: 42,
                height: 42,
                color: (controller.activity.value.field_guest_type
                            ?.endsWith(entity.name.toLowerCase()) ??
                        false)
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).hintColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          entity.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: (controller.activity.value.field_guest_type
                          ?.endsWith(entity.name) ??
                      false)
                  ? FontWeight.bold
                  : FontWeight.normal),
        )
      ],
    );
  }
}
