import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:rnginfra/src/guards/patroll/domain/entitites/patroll.entity.dart';

class PatrollDatePicker extends StatefulWidget {
  const PatrollDatePicker(
      {Key? key, this.patroll, required this.onDatePicked, required this.date})
      : super(key: key);
  final PatrollEntity? patroll;
  final DateTime date;
  final Function(DateTime date) onDatePicked;
  @override
  State<PatrollDatePicker> createState() => _PatrollDatePickerState();
}

class _PatrollDatePickerState extends State<PatrollDatePicker> {
  late DateTime temp;
  @override
  void initState() {
    temp = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: 22,
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
          // PadelAvatar(
          //     item: widget.patroll,
          //     borderColor: Colors.transparent,
          //     radius: 30,
          //     margins: const EdgeInsets.all(8),
          //     hero: '',
          //     onClick: () {}),

          const SizedBox(
            height: 16,
          ),
          Text(
            'Filter by Date', //widget.patroll.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).hintColor),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Text(
          //   'Filter by Date', //widget.patroll.body,
          //   style: Theme.of(context).textTheme.bodySmall,
          // ),
          const SizedBox(
            height: 30,
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
                firstDate: DateTime.now().subtract(const Duration(hours: 24)),
                lastDate: DateTime.now().add(const Duration(days: 365))),
          ),
          // WhenSearchCard(
          //   activate: () {},
          //   active: true,
          //   onChange: (date) {
          //     widget.onDatePicked(date);
          //   },
          //   value: widget.date,
          //   startDate: DateTime.now().subtract(const Duration(hours: 24)),
          //   endDate: DateTime.now().add(const Duration(days: 365)),
          // ),
        ],
      ),
    );
  }
}
