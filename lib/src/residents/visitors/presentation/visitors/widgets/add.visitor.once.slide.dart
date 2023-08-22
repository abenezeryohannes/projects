import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rnginfra/src/residents/visitors/presentation/visitors/controller/add.visitor.activity.controller.dart';

import '../../../../../core/widgets/text.input.form.dart';
import '../../../../../guards/activity/domain/entities/activity.type.entity.dart';

class AddVisitorOnceSlide extends StatefulWidget {
  const AddVisitorOnceSlide({super.key, required this.controller});
  final AddVisitorActivityController controller;
  @override
  State<AddVisitorOnceSlide> createState() => _AddVisitorOnceSlideState();
}

class _AddVisitorOnceSlideState extends State<AddVisitorOnceSlide> {
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
                    'Choose your visitor Type',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  content: activityTypeForm()),
              Step(
                  isActive: widget.controller.activeStepFrequent == 1,
                  title: Text(
                    'Set visitor Info',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  content: userForm()),
            ]));
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
                  minLines: 5,
                  maxLines: 10,
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
          padding: const EdgeInsets.only(top: 30.0),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: 1, //widget.controller.canGoToStep3() ? 1 : 0,
            child: TextButton(
                onPressed: () {
                  widget.controller.save(context);
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
}
