import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:rnginfra/src/auth/domain/entities/user.entity.dart';
import 'package:rnginfra/src/core/widgets/autocomplete.text.form.dart';
import 'package:rnginfra/src/core/widgets/big.text.button.dart';
import 'package:rnginfra/src/core/widgets/text.input.form.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/activity.type.entity.dart';
import 'package:rnginfra/src/guards/activity/presentation/new_activity/controller/add.activity.controller.dart';
import '../../../../../../main/injectable/getit.dart';
import '../../guests/widgets/image.form.dart';

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

    controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Hero(
          tag: 'ADD_ACTIVITY',
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton.outlined(
                          onPressed: () {
                            Navigator.maybePop(context);
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.grey.shade700,
                            size: 34,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                EasyStepper(
                  activeStep: controller.activeStep,
                  lineLength: 140,
                  lineSpace: 0,
                  direction: Axis.horizontal,
                  lineType: LineType.normal,
                  defaultLineColor: Theme.of(context).colorScheme.background,
                  finishedLineColor: Theme.of(context).colorScheme.secondary,
                  activeStepTextColor: Colors.black87,
                  finishedStepTextColor: Colors.black87,
                  internalPadding: 0,
                  showLoadingAnimation: false,
                  stepRadius: 8,
                  showStepBorder: false,
                  lineThickness: 1.5,
                  steps: [
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 7,
                            backgroundColor: controller.activeStep >= 0
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.background),
                      ),
                      title: 'Choose Type',
                    ),
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 7,
                            backgroundColor: controller.activeStep >= 1
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.background),
                      ),
                      title: 'Order Received',
                    ),
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 7,
                            backgroundColor: controller.activeStep >= 2
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.background),
                      ),
                      title: 'Preparing',
                    ),
                  ],
                  onStepReached: (index) =>
                      setState(() => controller.activeStep = index),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 40, right: 40),
                  child: manageStepper(),
                )),
                // SizedBox(
                //   height: 100,
                //   child: Obx(
                //     () => ListView.builder(
                //         shrinkWrap: true,
                //         scrollDirection: Axis.horizontal,
                //         itemCount: controller.activityTypes.value.length,
                //         itemBuilder: (context, index) {
                //           ActivityTypeEntity item =
                //               controller.activityTypes.value[index];
                //           return _activityTypeCard(item);
                //         }),
                //   ),
                // )
              ],
            ),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 30,
            ),
            ImageForm(
              link: controller
                  .activityUser.value.avatar, //'assets/img/person.jpeg',
              radius: 100,
              editing: true,
              onChange: (String? local) async {
                setState(() {
                  controller.activityUser.value = UserEntity(
                      name: controller.activityUser.value.name,
                      phoneNumber: controller.activityUser.value.phoneNumber,
                      position: controller.activityUser.value.position,
                      avatar: local,
                      uid: '');
                });
              },
            ),

            //add name;
            SizedBox(
              width: MediaQuery.of(context).size.width * (10 / 12),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TextInputForm(
                  radius: 10,
                  elevation: 0,
                  fillColor: Colors.transparent,
                  focusedBorderColor: Theme.of(context).colorScheme.secondary,
                  focusedBorderWidth: 2,
                  validator: (val) => (val?.length ?? 0) < 4
                      ? 'Must be at least 4 characters!'
                      : null,
                  onChanged: (String val) {
                    setState(() {
                      controller.activity.value.User = UserEntity(
                          name: val,
                          avatar:
                              controller.activity.value.User?.phoneNumber ?? '',
                          phoneNumber:
                              controller.activity.value.User?.phoneNumber ?? '',
                          uid: '');
                    });
                  },
                  placeholder: 'Full Name',
                ),
              ),
            ),

            //add name;
            SizedBox(
              width: MediaQuery.of(context).size.width * (10 / 12),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextInputForm(
                  radius: 10,
                  elevation: 0,
                  keybardType: TextInputType.phone,
                  fillColor: Colors.transparent,
                  focusedBorderColor: Theme.of(context).colorScheme.secondary,
                  focusedBorderWidth: 2,
                  validator: (val) => (val?.length ?? 0) < 4
                      ? 'Must be at least 4 characters!'
                      : null,
                  onChanged: (String val) {
                    setState(() {
                      controller.activity.value.User = UserEntity(
                          name: val,
                          avatar:
                              controller.activity.value.User?.phoneNumber ?? '',
                          phoneNumber:
                              controller.activity.value.User?.phoneNumber ?? '',
                          uid: '');
                    });
                  },
                  placeholder: 'Phone Number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50.0, bottom: 40, left: 10, right: 10),
              child: Text(
                'Full name and picture of the person who is doing the activity',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: controller.activity.value.User?.name == null ? 0 : 1,
            child: BigTextButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
              cornerRadius: 20,
              backgroudColor: Theme.of(context).colorScheme.secondary,
              onClick: () {
                setState(() {
                  controller.activeStep += 1;
                });
              },
              text: "Continue",
            ),
          ),
        )
      ],
    );
  }

  Widget activityTypeForm() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 300,
            child: Wrap(
              spacing: 30,
              runSpacing: 40,
              direction: Axis.horizontal,
              children: controller.activityTypes.value.map((e) {
                return _activityTypeCard(e);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
            child: Text(
              'Please select the type of activity you are going to add!',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: controller.activity.value.ActivityType == null ? 0 : 1,
              child: BigTextButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                cornerRadius: 20,
                backgroudColor: Theme.of(context).colorScheme.secondary,
                onClick: () {
                  setState(() {
                    controller.activeStep = 1;
                  });
                },
                text: "Continue",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget validatorForm() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: AutoCompleteTextForm(
                  radius: 20,
                  elevation: 1,
                  validator: (val) => (val?.length ?? 0) < 4
                      ? 'Must be at least 4 characters!'
                      : null,
                  initialValue: controller.type.value,
                  onChanged: (String val) {
                    setState(() {
                      controller.type.value = val;
                    });
                  },
                  fillColor: Colors.transparent,
                  placeholder: 'Validator Staff Member',
                  onSelected: (String selected) {},
                  enabled: true,
                  suggestions: controller.staffs.value,
                  suggestionPropertyToShow: 'fullName',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 20),
                child: Text(
                  'Please select a staff member who will be reponsible for this activity!',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: controller.activity.value.ActivityType == null ? 0 : 1,
              child: BigTextButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                cornerRadius: 20,
                backgroudColor: Theme.of(context).colorScheme.secondary,
                onClick: () {
                  setState(() {
                    controller.initialize();
                    Navigator.maybePop(context);
                  });
                },
                text: "save",
              ),
            ),
          ),
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
              controller.activity.value.ActivityType = entity;
            });
          },
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                color: Color(int.parse(entity.color ?? '0xFFF4F4F4'))
                    .withOpacity(controller.activity.value.ActivityType?.name !=
                            entity.name
                        ? 0.8
                        : 1),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            //margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Center(
              child: Image.asset(
                entity.icon ?? 'assets/icon/calendar.png',
                width: 42,
                height: 42,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          entity.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight:
                  controller.activity.value.ActivityType?.name != entity.name
                      ? FontWeight.normal
                      : FontWeight.bold),
        )
      ],
    );
  }
}
