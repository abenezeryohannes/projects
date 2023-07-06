import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextInput extends StatefulWidget {
  const PhoneTextInput(
      {super.key,
      required this.focusNode,
      required this.prefix,
      required this.value,
      required this.hint,
      required this.onChanged,
      required this.prefixGap,
      required this.contentPadding});

  final FocusNode focusNode;
  final Widget prefix;
  final int prefixGap;
  final double contentPadding;
  final String value;
  final String hint;
  final Function(String) onChanged;

  @override
  State<PhoneTextInput> createState() => _PhoneTextInputState();
}

class _PhoneTextInputState extends State<PhoneTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: false,
      focusNode: widget.focusNode,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
      keyboardType: TextInputType.phone,
      //initialValue: widget.value,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.start,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      // controller: controller,
      controller: TextEditingController.fromValue(TextEditingValue(
          text: widget.value,
          selection: TextSelection.collapsed(offset: widget.value.length))),
      decoration: InputDecoration(
        focusColor: Colors.white,
        prefixIcon: widget.prefix,
        prefixIconConstraints:
            BoxConstraints(minWidth: widget.prefixGap!.toDouble()),
        hintText: widget.hint,
        filled: true, fillColor: Colors.transparent,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        floatingLabelBehavior: FloatingLabelBehavior.never,

        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.grey.shade300, fontSize: 24),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        contentPadding: EdgeInsets.symmetric(horizontal: widget.contentPadding),
        // errorText:     !validCode ? widget.tr('field_required') : null,
      ),
      onChanged: (val) {
        widget.onChanged(val);
      },
    );
  }
}
