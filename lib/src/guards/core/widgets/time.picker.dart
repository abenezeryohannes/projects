import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomeTimePicker extends StatefulWidget {
  const CustomeTimePicker(
      {super.key,
      this.time,
      this.txt,
      required this.icon,
      required this.title,
      this.width,
      this.height,
      required this.onChange});

  final DateTime? time;
  final String? txt;
  final Widget icon;
  final String title;
  final double? width;
  final double? height;
  final Function(DateTime change) onChange;

  @override
  State<CustomeTimePicker> createState() => _CustomeTimePickerState();
}

class _CustomeTimePickerState extends State<CustomeTimePicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          TimeOfDay? value = await showTimePicker(
              initialEntryMode: TimePickerEntryMode.inputOnly,
              initialTime: TimeOfDay.fromDateTime(DateTime.now()),
              context: context,
              hourLabelText: '',
              minuteLabelText: '');

          if (value != null) {
            widget.onChange(DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, value.hour, value.minute, 0));
          }
        },
        child: _timeCard(
          icon: widget.icon,
          title: widget.title,
          time: widget.time,
        ));
  }

  Widget _timeCard({
    required Widget icon,
    required String title,
    DateTime? time,
  }) {
    return Container(
      width: widget.width ?? 140,
      height: widget.height ?? 140,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).disabledColor.withOpacity(0.1),
                offset: const Offset(5, 5),
                blurRadius: 2)
          ],
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            (time == null) ? '-' : (DateFormat('MMM d, yyyy').format(time)),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(),
          ),
          if (time != null)
            Text(
              (DateFormat('E, hh:mm a').format(time)),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(),
            ),
        ],
      ),
    );
  }
}
