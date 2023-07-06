import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:rnginfra/src/auth/presentation/widgets/country.code.selector.dart';
import 'package:rnginfra/src/auth/presentation/widgets/phone.text.input.dart';
import 'package:rnginfra/src/core/animations/delayed.animation.dart';

import '../../../../core/animations/getstarted/button.size.animation.dart';
import '../../../../core/widgets/big.text.button.dart';
import '../../../domain/entities/country.entity.dart';
import '../../widgets/my.keyboard.widget.dart';

class SignupSlide extends StatefulWidget {
  const SignupSlide({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.hint,
    this.error,
    required this.countries,
    required this.country,
    required this.onCountryChange,
    required this.onNext,
    required this.loading,
    required this.onBack,
  }) : super(key: key);
  final Function(String val) onChanged;
  final Function(MyCountry? val) onCountryChange;
  final String value;
  final String? error;
  final String hint;
  final List<MyCountry> countries;
  final bool loading;
  final MyCountry? country;
  final Function onNext;
  final Function onBack;
  @override
  State<SignupSlide> createState() => _SignupSlideState();
}

class _SignupSlideState extends State<SignupSlide> {
  final TextEditingController controller = TextEditingController(text: "");
  final FocusNode _focusNodeCode = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  String tempCode = '';
  int delayed = 500;

  @override
  void initState() {
    super.initState();
    _focusNodePhone.requestFocus();
    _focusNodeCode.addListener(() {
      processPhoneCodeInput(tempCode);
    });

    tempCode = widget.country?.dial_code ?? '';
  }

  @override
  Widget build(BuildContext context) {
    delayed = 500;
    controller.text = widget.value;
    return SizedBox(
      height: MediaQuery.of(context).size.height * (10 / 12) - 3,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DelayedAnimation(
                  delay: delayed -= 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                    child: IconButton.outlined(
                        onPressed: () {
                          widget.onBack();
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.grey.shade500,
                          size: 34,
                        )),
                  ),
                ),
                DelayedAnimation(
                  delay: delayed -= 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Enter your \nphone number',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DelayedAnimation(
                  delay: delayed -= 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Text(
                      'We will send you a confirmation code within 2 minutes.',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DelayedAnimation(
                  delay: delayed -= 100,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: PhoneTextInput(
                        focusNode: _focusNodePhone,
                        prefix: _countryCodeSelector(),
                        prefixGap: 60,
                        value: widget.value,
                        hint: widget.hint,
                        onChanged: (val) => widget.onChanged(val),
                        contentPadding: 14,
                      )),
                ),
              ],
            ),
            DelayedAnimation(
              delay: delayed -= 150,
              child: MyKeboard(
                fontSize: 28,
                onKeyDown: (char) {
                  if (_focusNodePhone.hasFocus) {
                    if (char.endsWith("back")) {
                      if (widget.value.isNotEmpty) {
                        widget.onChanged(
                            widget.value.substring(0, widget.value.length - 1));
                      }
                      if (widget.value.length == 1 || widget.value.isEmpty) {
                        _focusNodeCode.requestFocus();
                      }
                    } else if (char.length == 1) {
                      widget.onChanged(widget.value + char);
                    }
                  } else if (_focusNodeCode.hasFocus) {
                    if (char.endsWith("back") && tempCode.isNotEmpty) {
                      setState(() {
                        tempCode = tempCode.substring(0, tempCode.length - 1);
                      });
                    } else if (char.length == 1) {
                      setState(() {
                        tempCode += char;
                      });
                    }
                    if (processPhoneCodeInput(tempCode) ||
                        (tempCode.length >= 4 && !char.endsWith("back"))) {
                      _focusNodePhone.requestFocus();
                    }
                  }
                },
              ),
            ),
            if (widget.error != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 42.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.error!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            Column(
              children: [
                ButtonSizeAnimation(
                  delay: delayed + 400,
                  begin: 0.7,
                  end: 1,
                  milli: 1000,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: BigTextButton(
                      onClick: () {
                        widget.onNext();
                      },
                      text: 'Next',
                      fontSize: 20,
                      fontWight: FontWeight.bold,
                      horizontalMargin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      cornerRadius: 22,
                      isLoading: (widget.loading),
                    ),
                  ),
                ),
                DelayedAnimation(
                  delay: delayed -= 250,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 20, right: 20),
                    child: Text(
                      'By creating passcode you agree with our Terms & Conditions and Privacy Policy',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }

  Widget _countryCodeSelector() {
    return CountryCodeSelector(
        focusNode: _focusNodeCode,
        value: tempCode,
        country: widget.country,
        countries: widget.countries);
  }

  bool processPhoneCodeInput(String val) {
    MyCountry? match = widget.countries.firstWhereOrNull((element) =>
        element.dial_code.replaceAll("+", "") == (val.replaceAll("+", "")));
    if (match != null) {
      widget.onCountryChange(match);
      setState(() {
        tempCode = match.dial_code;
      });
    } else {
      setState(() {
        tempCode = val;
        widget.onCountryChange(null);
      });
    }
    return match != null;
  }
}
