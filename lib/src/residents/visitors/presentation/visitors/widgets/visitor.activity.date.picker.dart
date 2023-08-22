import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class VisitorActivityDatePicker extends StatefulWidget {
  const VisitorActivityDatePicker(
      {Key? key, required this.onDatePicked, required this.date})
      : super(key: key);
  final DateTime date;
  final Function(DateTime date) onDatePicked;
  @override
  State<VisitorActivityDatePicker> createState() =>
      _VisitorActivityDatePickerState();
}

class _VisitorActivityDatePickerState extends State<VisitorActivityDatePicker> {
  late DateTime temp;
  @override
  void initState() {
    temp = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      height: MediaQuery.of(context).size.height * (6 / 12),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0),
            color: Theme.of(context).dividerColor,
            width: 60,
            height: 6,
          ),
          const SizedBox(
            height: 16,
          ),
          Material(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/icon/calendar.png',
                width: 16,
                height: 16,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Filter by Date',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).hintColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: DayPicker.single(
                selectedDate: temp,
                // datePickerStyles: DatePickerStyles(),
                datePickerLayoutSettings: DatePickerLayoutSettings(
                    dayPickerRowHeight: 35,
                    monthPickerPortraitWidth:
                        MediaQuery.of(context).size.width * (10 / 12),
                    contentPadding: const EdgeInsets.only(left: 0)),
                onChanged: (date) {
                  setState(() {
                    temp = date;
                  });
                  widget.onDatePicked(date);
                },
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 1))),
          ),
        ],
      ),
    );
  }
}
