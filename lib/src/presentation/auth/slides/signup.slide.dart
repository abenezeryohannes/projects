import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import '../../../appcore/animations/delayed.animation.dart';

import '../../../appcore/animations/button.size.animation.dart';
import '../../../appcore/widgets/big.text.button.dart';
import '../../../domain/auth/entities/country.entity.dart';
import '../../privacy.bottom.sheet.dart';
import '../widgets/country.code.selector.dart';
import '../widgets/my.keyboard.widget.dart';
import '../widgets/phone.text.input.dart';

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
      height: MediaQuery.of(context).size.height * (10 / 12) + 50,
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DelayedAnimation(
                        delay: delayed -= 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: IconButton(
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
                            'enter_your_phone_number'.tr,
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
                            'we_will_send_you_confirmation_code'.tr,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                ),
                DelayedAnimation(
                  delay: delayed -= 150,
                  child: MyKeboard(
                    fontSize: 28,
                    onKeyDown: (char) {
                      if (_focusNodePhone.hasFocus) {
                        if (char.endsWith("back")) {
                          if (widget.value.isNotEmpty) {
                            widget.onChanged(widget.value
                                .substring(0, widget.value.length - 1));
                          }
                          if (widget.value.length == 1 ||
                              widget.value.isEmpty) {
                            _focusNodeCode.requestFocus();
                          }
                        } else if (char.length == 1) {
                          widget.onChanged(widget.value + char);
                        }
                      } else if (_focusNodeCode.hasFocus) {
                        if (char.endsWith("back") && tempCode.isNotEmpty) {
                          setState(() {
                            tempCode =
                                tempCode.substring(0, tempCode.length - 1);
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 42.0, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.error!,
                            maxLines: 2,
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
                          text: 'next'.tr,
                          fontSize: 20,
                          fontWight: FontWeight.bold,
                          borderColor: Theme.of(context).colorScheme.secondary,
                          backgroudColor:
                              Theme.of(context).colorScheme.secondary,
                          horizontalMargin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          cornerRadius: 22,
                          isLoading: (widget.loading),
                        ),
                      ),
                    ),
                    if (widget.error == null)
                      DelayedAnimation(
                        delay: delayed -= 250,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 40, right: 40),
                          child: Text.rich(
                            TextSpan(
                                text: '${'you_aggree_with_terms'.tr}  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                        fontSize: 14),
                                children: [
                                  WidgetSpan(
                                      child: InkWell(
                                    onTap: () {
                                      context.pushTransparentRoute(
                                          const PrivacyBottomSheet());
                                    },
                                    child: Text(('terms_and_privacy'.tr),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                  ))
                                ]),
                          ),
                        ),
                      ),
                  ],
                ),
              ]),
        ),
      ),
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
