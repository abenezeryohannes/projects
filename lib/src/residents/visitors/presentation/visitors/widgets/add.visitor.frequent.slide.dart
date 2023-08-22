import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rnginfra/src/core/widgets/big.text.button.dart';
import 'package:rnginfra/src/residents/visitors/presentation/visitors/controller/add.visitor.activity.controller.dart';

import '../../../../../core/widgets/text.input.form.dart';
import '../../../../../guards/activity/domain/entities/activity.type.entity.dart';

class AddVisitorFrequentSlide extends StatefulWidget {
  const AddVisitorFrequentSlide(
      {super.key, required this.controller, required this.restorationId});
  final AddVisitorActivityController controller;
  final String restorationId;
  @override
  State<AddVisitorFrequentSlide> createState() =>
      _AddVisitorFrequentSlideState();
}

class _AddVisitorFrequentSlideState extends State<AddVisitorFrequentSlide>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedStartDate =
      RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _startDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectStartDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerStartRoute,
        arguments: _selectedStartDate.value.millisecondsSinceEpoch,
      );
    },
  );

  final RestorableDateTime _selectedEndDate =
      RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _endDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectEndDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerEndRoute,
        arguments: _selectedEndDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerStartRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'start_date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 3000)),
        );
      },
    );
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerEndRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'end_date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 3000)),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedStartDate, 'selected_start_date');
    registerForRestoration(_selectedEndDate, 'selected_end_date');
    registerForRestoration(
        _startDatePickerRouteFuture, 'start_date_picker_route_future');
    registerForRestoration(
        _endDatePickerRouteFuture, 'end_date_picker_route_future');
  }

  void _selectStartDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedStartDate.value = newSelectedDate;
        widget.controller.visitation.value.field_guest_frequent_start =
            (newSelectedDate.millisecondsSinceEpoch * 1000).toString();
      });
    }
  }

  void _selectEndDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedEndDate.value = newSelectedDate;
        widget.controller.visitation.value.field_guest_frequent_end =
            (newSelectedDate.millisecondsSinceEpoch * 1000).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _once();
  }

  Widget _once() {
    return Obx(() => Stepper(
            currentStep: widget.controller.activeStepFrequent,
            onStepTapped: (value) {
              setState(() {
                if (value < widget.controller.activeStepFrequent) {
                  widget.controller.activeStepFrequent = value;
                }
              });
            },
            controlsBuilder: (context, details) => const SizedBox(),
            steps: [
              Step(
                  isActive: widget.controller.activeStepFrequent == 0,
                  label: null,
                  title: Text(
                    'Allow entry for next',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  content: chooseFrequence()),
              Step(
                  isActive: widget.controller.activeStepFrequent == 1,
                  label: null,
                  title: Text(
                    'Choose your visitor Type',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  content: activityTypeForm()),
              Step(
                  isActive: widget.controller.activeStepFrequent == 2,
                  title: Text(
                    'Set visitor Info',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  content: userForm()),
            ]));
  }

  Widget chooseFrequence() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: BigTextButton(
                onClick: () {
                  setFrequencyToAWeek();
                },
                borderColor: isFrequenceAWeek()
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onBackground,
                backgroudColor: isFrequenceAWeek()
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).scaffoldBackgroundColor,
                textColor: isFrequenceAWeek()
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackground,
                fontSize: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                text: '1 Week',
              ),
            ),
            SizedBox(
              width: 70,
              child: BigTextButton(
                onClick: () {
                  setFrequencyToAMonth();
                },
                borderColor: isFrequenceAMonth()
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onBackground,
                backgroudColor: isFrequenceAMonth()
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).scaffoldBackgroundColor,
                textColor: isFrequenceAMonth()
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackground,
                fontSize: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                text: '1 Month',
              ),
            ),
            SizedBox(
              width: 70,
              child: BigTextButton(
                onClick: () {
                  setCustom();
                },
                borderColor: isCustom()
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onBackground,
                backgroudColor: isCustom()
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).scaffoldBackgroundColor,
                textColor: isCustom()
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackground,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                fontSize: 10,
                text: 'Custom',
              ),
            )
          ],
        ),
        //
        //
        const SizedBox(
          height: 20,
        ),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Date',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: isCustom()
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).disabledColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  child: BigTextButton(
                    onClick: () {
                      if (isCustom()) {
                        _startDatePickerRouteFuture.present();
                      }
                    },
                    borderColor: isCustom()
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).disabledColor,
                    backgroudColor: Theme.of(context).scaffoldBackgroundColor,
                    textColor: isCustom()
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).disabledColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    textWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('d MMM').format(_selectedStartDate.value),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isCustom()
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).disabledColor,
                              ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: isCustom()
                              ? Theme.of(context).disabledColor
                              : Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.3),
                          size: 24,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'End Date',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: isCustom()
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).disabledColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  child: BigTextButton(
                    onClick: () {
                      if (isCustom()) {
                        _endDatePickerRouteFuture.present();
                      }
                    },
                    borderColor: isCustom()
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).disabledColor,
                    backgroudColor: Theme.of(context).scaffoldBackgroundColor,
                    textColor: Theme.of(context).colorScheme.onBackground,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    textWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('d MMM').format(_selectedEndDate.value),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isCustom()
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).disabledColor,
                              ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: isCustom()
                              ? Theme.of(context).disabledColor
                              : Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.3),
                          size: 24,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
            //
            //
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: 1, //widget.controller.canGoToStep3() ? 1 : 0,
            child: TextButton(
                onPressed: () {
                  copyDateAndTime();
                  setState(() {
                    widget.controller.activeStepFrequent =
                        widget.controller.activeStepFrequent + 1;
                  });
                },
                child: Text(
                  'Continue',
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

  Widget userForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.controller.visitation.value.field_guest_type
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
                    initialValue: widget.controller.visitation.value
                        .field_vehicle_identification,
                    validator: (val) => (val?.length ?? 0) < 4
                        ? 'Must be at least 4 characters!'
                        : null,
                    onChanged: (String val) {
                      setState(() {
                        widget.controller.visitation.value
                            .field_vehicle_identification = val;
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
                    top: (widget.controller.visitation.value.field_guest_type
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
                  initialValue:
                      widget.controller.visitation.value.field_short_notes,
                  validator: (val) => (val?.length ?? 0) < 4
                      ? 'Must be at least 3 characters!'
                      : null,
                  onChanged: (String val) {
                    setState(() {
                      widget.controller.visitation.value.field_short_notes =
                          val;
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
                  minLines: 3,
                  maxLines: 5,
                  fillColor: Colors.transparent,
                  focusedBorderColor: Theme.of(context).colorScheme.secondary,
                  focusedBorderWidth: 2,
                  initialValue:
                      widget.controller.visitation.value.field_long_notes,
                  validator: (val) => (val?.length ?? 0) < 4
                      ? 'Must be at least 4 characters!'
                      : null,
                  onChanged: (String val) {
                    setState(() {
                      widget.controller.visitation.value.field_long_notes = val;
                    });
                  },
                  placeholder: 'Long Note',
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: 1, //widget.controller.canGoToStep3() ? 1 : 0,
            child: TextButton(
                onPressed: () => {widget.controller.save(context)},
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
                children: widget.controller.activityTypes.value.map((e) {
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

  Widget _activityTypeCard(ActivityTypeEntity entity) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              widget.controller.visitation.value.field_guest_type =
                  entity.name.toLowerCase();
              widget.controller.visitation.refresh();
              widget.controller.activeStepFrequent += 1;
            });
          },
          child: Container(
            width: 90,
            height: 70,
            decoration: BoxDecoration(
                color: (widget.controller.visitation.value.field_guest_type
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
                color: (widget.controller.visitation.value.field_guest_type
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
              fontWeight: (widget.controller.visitation.value.field_guest_type
                          ?.endsWith(entity.name) ??
                      false)
                  ? FontWeight.bold
                  : FontWeight.normal),
        )
      ],
    );
  }

  void setFrequencyToAWeek() {
    setState(() {
      _selectedStartDate.value = DateTime.now();
      _selectedEndDate.value = DateTime.now().add(const Duration(days: 7));
    });
    copyDateAndTime();
  }

  void setFrequencyToAMonth() {
    setState(() {
      _selectedStartDate.value = DateTime.now();
      _selectedEndDate.value = DateTime.now().add(const Duration(days: 31));
    });
    copyDateAndTime();
  }

  void setCustom() {
    final date = DateTime.now().add(const Duration(days: 22));
    setState(() {
      _selectedStartDate.value = DateTime.now();
      _selectedEndDate.value = date;
    });
    copyDateAndTime();
  }

  bool isFrequenceAWeek() {
    final date = DateTime.now().add(const Duration(days: 7));
    return _selectedStartDate.value.day == DateTime.now().day &&
        _selectedEndDate.value.day == date.day;
  }

  bool isFrequenceAMonth() {
    final date = DateTime.now().add(const Duration(days: 31));

    return _selectedStartDate.value.day == DateTime.now().day &&
        _selectedEndDate.value.day == date.day;
  }

  void copyDateAndTime() {
    widget.controller.visitation.value
        .setFrequentEntry(_selectedStartDate.value);
    widget.controller.visitation.value.setFrequentExit(_selectedEndDate.value);
  }

  bool isCustom() {
    return !isFrequenceAWeek() && !isFrequenceAMonth();
  }
}
