import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/animations/delayed.animation.dart';
import 'package:rnginfra/src/core/animations/getstarted/button.size.animation.dart';
import 'package:rnginfra/src/core/widgets/big.text.button.dart';
import 'package:rnginfra/src/core/widgets/show.error.dart';
import 'package:rnginfra/src/guards/activity/presentation/staffs/controllers/add.staff.attendance.controller.dart';

import '../../../../../core/widgets/autocomplete.text.form.dart';

class AddStaffAttendance extends StatefulWidget {
  const AddStaffAttendance({super.key});

  @override
  State<AddStaffAttendance> createState() => _AddStaffAttendanceState();
}

class _AddStaffAttendanceState extends State<AddStaffAttendance> {
  late AddStaffAttendanceController controller;
  int delayed = 0;
  @override
  void initState() {
    controller = getIt<AddStaffAttendanceController>();
    controller.getStaffs(search: '', limit: 100, page: 0);
    controller.staffSelected.value = null;
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
              color: Colors.white,
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
                  delay: delayed += 100,
                  child: Text(
                    (controller.staffActivity.value == null)
                        ? 'Record Staff Entrance'
                        : 'Staff Entrance Recorded',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DelayedAnimation(
                  delay: delayed += 100,
                  child: Text(
                    (controller.staffActivity.value == null)
                        ? 'Select a staff member from the option'
                        : 'You can record this user exit afterward!',
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).disabledColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (controller.staffActivity.value == null)
                  DelayedAnimation(
                    delay: delayed += 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 20),
                      child: AutoCompleteTextForm(
                        fillColor: Colors.white,
                        radius: 12,
                        rightMargin: MediaQuery.of(context).size.width / 4,
                        elevation: 1,
                        validator: (val) => (val?.length ?? 0) < 4
                            ? 'Must be at least 4 characters!'
                            : null,
                        onChanged: (String val) {
                          controller.getStaffs(
                              search: val, limit: 100, page: 0);
                          setState(() {
                            controller.staffSelected.value = null;
                          });
                        },
                        placeholder: 'Staff Members',
                        onSelected: (String selected) {
                          setState(() {
                            controller.staffSelected.value =
                                controller.staffUsers.value.firstWhereOrNull(
                                    (element) => element.name == selected);
                          });
                        },
                        suggestions: controller.staffUsers.value,
                        suggestionPropertyToShow: 'name',
                      ),
                    ),
                  ),
                (controller.staffActivityError.value != null)
                    ? Center(
                        child: ShowError(
                          failure: controller.staffActivityError.value!,
                          height: 100,
                          ErrorShowType: ErrorShowType.Horizontal,
                        ),
                      )
                    : const SizedBox(),
                ButtonSizeAnimation(
                  delay: 400,
                  milli: 1200,
                  begin: 0.7,
                  end: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50.0, left: 5, right: 5),
                    child: BigTextButton(
                      onClick: () {
                        if (controller.staffActivity.value == null) {
                          controller.addStaffActivity(
                              targetId: controller.staffSelected.value!.uid
                                  .toString(),
                              time: DateTime.now());
                        } else {
                          Navigator.maybePop(context);
                        }
                      },
                      backgroudColor: (controller.staffActivity.value == null)
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primaryContainer,
                      enabled: controller.staffSelected.value != null,
                      isLoading: false, //controller.loadingAddStaffs.value,
                      cornerRadius: 20,
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      text: (controller.staffActivity.value == null)
                          ? 'Record Staff Entrance'
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
            delay: delayed -= 800,
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
                                  "assets/icon/enter1.png",
                                  width: 40,
                                  height: 40,
                                )),
                          )
                        : const SizedBox(),
                  ),
                  Obx(
                    () => (controller.loadingAddStaffs.value)
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
}
