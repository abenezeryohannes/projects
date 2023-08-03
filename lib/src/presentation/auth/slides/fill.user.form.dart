import 'package:flutter/material.dart';

import '../../../appcore/widgets/big.text.button.dart';

class FillUserForm extends StatefulWidget {
  const FillUserForm({
    Key? key,
    required this.isLoading,
    // required this.userDto,
    required this.onFocus,
    required this.onUpload,
    required this.onNext,
    required this.onNameChange,
    required this.isKeyboardVisible,
  }) : super(key: key);
  final bool isKeyboardVisible;
  // final UserDto userDto;
  final Function(bool) isLoading;
  final Function(bool) onFocus;
  final Function(String) onUpload;
  final Function(String) onNameChange;
  final Function onNext;
  @override
  State<FillUserForm> createState() => _FillUserFormState();
}

class _FillUserFormState extends State<FillUserForm> {
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.addListener(() {
      widget.onFocus(_focusNode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * (10 / 12) - 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Text(
                      'Successfully Signed in!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.grey.shade700),
                    )),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  //TODO Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: TextInputForm(
                  //     label: 'Full Name',
                  //     focusNode: FocusNode(),
                  //     elevation: 1,
                  //     radius: 12,
                  //     validator: (value) => Util.validateNoEmpty(value),
                  //     floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     initialValue: widget.userDto.fullName,
                  //     onChanged: (change) {
                  //       widget.onNameChange(change);
                  //     },
                  //     placeholder: widget.userDto.fullName ?? '',
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
            // if (MediaQuery.of(context).viewInsets.bottom == 0 ||
            //     widget.isKeyboardVisible)
            //   Align(
            //     alignment: Alignment.bottomCenter,
            //     child: BigTextButton(
            //       onClick: () {
            //         widget.onNext();
            //       },
            //       text: 'Next',
            //       fontSize: 20,
            //       fontWight: FontWeight.bold,
            //       horizontalMargin:
            //           const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            //       padding: const EdgeInsets.symmetric(vertical: 16),
            //       cornerRadius: 22,
            //     ),
            //   ),
          ],
        ));
  }
}
