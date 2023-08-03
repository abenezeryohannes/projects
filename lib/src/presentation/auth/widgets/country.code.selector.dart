import 'package:flutter/material.dart';
import 'package:linko/src/presentation/auth/widgets/phone.text.input.dart';

import '../../../domain/auth/entities/country.entity.dart';

class CountryCodeSelector extends StatefulWidget {
  const CountryCodeSelector({
    super.key,
    required this.value,
    this.country,
    required this.focusNode,
    required this.countries,
  });
  final String value;
  final MyCountry? country;
  final FocusNode focusNode;
  final List<MyCountry> countries;
  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.country?.emoji != null)
            Text(widget.country!.emoji!,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                    fontSize: 18)),
          //   Image.asset(
          //     widget.country!.emoji!,
          //     width: 24,
          //     height: 16,
          //   ),
          InkWell(
            onTap: () {
              setState(() {
                widget.focusNode.requestFocus();
              });
            },
            child: SizedBox(
              width: 80,
              child: Row(
                children: [
                  Expanded(
                    child: PhoneTextInput(
                      focusNode: widget.focusNode,
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 6.0, bottom: 3),
                        child: Text("+",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade400,
                                fontSize: 24)),
                      ),
                      value: widget.value.replaceAll("+", ""),
                      hint: widget.value.replaceAll("+", ""),
                      onChanged: (val) {},
                      prefixGap: 10,
                      contentPadding: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            width: 1,
            margin: const EdgeInsets.only(left: 0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
          )
        ],
      ),
    );
  }
}
