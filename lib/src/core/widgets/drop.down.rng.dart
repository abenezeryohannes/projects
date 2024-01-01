import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownRNG<T> extends StatefulWidget {
  const DropDownRNG(
      {super.key,
      required this.items,
      required this.title,
      required this.onSelected,
      required this.getOptionText,
      this.value});
  final List<T> items;
  final String title;
  final T? value;
  final void Function(dynamic selected) onSelected;
  final String? Function(dynamic) getOptionText;
  @override
  State<DropDownRNG> createState() => _DropDownRNGState();
}

class _DropDownRNGState<T> extends State<DropDownRNG<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: widget.value,
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 10),

        border: OutlineInputBorder(
          // borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(15),
        ),
        // Add more decoration..
      ),
      hint: Text(
        widget.title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      items: widget.items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  widget.getOptionText(item) ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return widget.title;
        }
        return null;
      },
      onChanged: (value) {
        widget.onSelected(value as T);
      },
      onSaved: (value) {
        widget.onSelected(value as T);
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
