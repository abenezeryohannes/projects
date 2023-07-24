import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/animations/delayed.animation.dart';
import 'package:rnginfra/src/core/widgets/big.text.button.dart';
import 'package:rnginfra/src/core/widgets/show.error.dart';
import 'package:rnginfra/src/guards/activity/domain/entities/staff.attendance.entity.dart';
import 'package:rnginfra/src/guards/core/widgets/time.picker.dart';

import '../../../../../core/animations/getstarted/button.size.animation.dart';
import '../controllers/edit.staff.attendance.controller.dart';

class EditStaffAttendance extends StatefulWidget {
  const EditStaffAttendance({super.key, required this.staffAttendanceEntity});
  final StaffAttendanceEntity staffAttendanceEntity;
  @override
  State<EditStaffAttendance> createState() => _EditStaffAttendanceState();
}

class _EditStaffAttendanceState extends State<EditStaffAttendance> {
  late EditStaffAttendanceController controller;

  @override
  void initState() {
    controller = getIt<EditStaffAttendanceController>();
    controller.entranceTime.value = widget.staffAttendanceEntity.entryAt();
    controller.exitTime.value = widget.staffAttendanceEntity.exitAt();
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
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: 20, top: 45 + 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DelayedAnimation(
                  delay: 100,
                  child: Text(
                    widget.staffAttendanceEntity.field_user_staff ??
                        '----------------',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DelayedAnimation(
                  delay: 200,
                  child: Text(
                    controller.staffActivity.value == null
                        ? 'Click on the cards to edit the time'
                        : 'Updated Succesfully !!',
                    style: TextStyle(
                        fontSize: 14,
                        color: controller.staffActivity.value == null
                            ? Theme.of(context).disabledColor
                            : Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DelayedAnimation(
                      delay: 200,
                      child: Obx(
                        () => CustomeTimePicker(
                          icon: Image.asset(
                            'assets/icon/enter.png',
                            width: 32,
                            height: 32,
                          ),
                          time: controller.entranceTime.value,
                          title: 'Entry Time',
                          onChange: (DateTime change) {
                            setState(() {
                              controller.entranceTime.value = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  change.hour,
                                  change.minute,
                                  0);
                            });
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        TimeOfDay? value = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.inputOnly,
                            initialTime: TimeOfDay.fromDateTime(
                                controller.exitTime.value ?? DateTime.now()),
                            context: context,
                            hourLabelText: '',
                            minuteLabelText: '');

                        if (value != null) {
                          setState(() {
                            controller.exitTime.value = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                value.hour,
                                value.minute,
                                0);
                          });
                        }
                      },
                      child: DelayedAnimation(
                        delay: 200,
                        child: Obx(
                          () => CustomeTimePicker(
                            icon: Image.asset(
                              'assets/icon/exit.png',
                              width: 32,
                              height: 32,
                            ),
                            time: controller.exitTime.value,
                            title: 'Leave Time',
                            onChange: (DateTime change) {
                              setState(() {
                                controller.exitTime.value = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    change.hour,
                                    change.minute,
                                    0);
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                (controller.staffActivityError.value != null)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ShowError(
                          failure: controller.staffActivityError.value!,
                          ErrorShowType: ErrorShowType.Horizontal,
                        ),
                      )
                    : const SizedBox(
                        height: 40,
                      ),
                ButtonSizeAnimation(
                  delay: 300,
                  milli: 1000,
                  begin: 0.7,
                  end: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: BigTextButton(
                      onClick: () {
                        if ((controller.staffActivity.value != null)) {
                          StaffAttendanceEntity at =
                              StaffAttendanceEntity.fromJson(
                                  widget.staffAttendanceEntity.toJson());
                          at.field_staff_entry =
                              StaffAttendanceEntity.GetDateString(
                                  controller.entranceTime.value);
                          at.field_staff_exit =
                              StaffAttendanceEntity.GetDateString(
                                  controller.exitTime.value);
                          Navigator.maybePop(context, at);
                        } else if ((controller.exitTime.value != null ||
                            controller.entranceTime.value != null)) {
                          controller.editStaffActivity(
                              targetId: widget.staffAttendanceEntity.id,
                              exitTime: controller.exitTime.value,
                              entranceTime: controller.entranceTime.value);
                        }
                      },
                      backgroudColor: (controller.staffActivity.value == null)
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primaryContainer,
                      enabled: controller.exitTime.value != null &&
                          controller.entranceTime.value != null &&
                          !controller.loadingEditStaffs.value,
                      isLoading: false, //controller.loadingEditStaffs.value,
                      cornerRadius: 20,
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      text: (controller.staffActivity.value == null)
                          ? 'Save'
                          : 'ok',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: DelayedAnimation(
            delay: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey.shade500,
                      spreadRadius: 1)
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(
                    () => (controller.staffActivity.value == null)
                        ? CircleAvatar(
                            backgroundColor: Theme.of(context).cardColor,
                            radius: 40,
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(45)),
                                child: Image.asset(
                                  "assets/icon/user.png",
                                  width: 60,
                                  height: 60,
                                )),
                          )
                        : const SizedBox(),
                  ),
                  Obx(
                    () => (controller.loadingEditStaffs.value)
                        ? SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        : controller.staffActivity.value != null
                            ? AnimateIcon(
                                key: UniqueKey(),
                                onTap: () {},
                                iconType: IconType.animatedOnTap,
                                height: 70,
                                width: 70,
                                color: Theme.of(context).colorScheme.secondary,
                                animateIcon: AnimateIcons.checkmarkOk,
                              )
                            : const SizedBox(),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void selectTime(TimeOfDay initial) async {
    final selectedTime = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            SizedBox(
              child: TimePickerDialog(
                initialEntryMode: TimePickerEntryMode.dialOnly,
                initialTime: initial,
                cancelText: "",
                confirmText: "",
              ),
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    selectedTime();
  }
}
