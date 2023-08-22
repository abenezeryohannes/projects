import 'package:flutter/material.dart';

import '../../../../core/animations/delayed.animation.dart';
import '../../../../core/animations/getstarted/button.size.animation.dart';
import '../../../../core/widgets/big.text.button.dart';
import '../../widgets/countdown.dart';
import '../../widgets/my.keyboard.widget.dart';

class ConfirmSlide extends StatefulWidget {
  const ConfirmSlide(
      {Key? key,
      required this.onResendCode,
      required this.code,
      required this.onCodeChange,
      this.error,
      required this.phoneNumber,
      required this.onConfirm,
      required this.onBack,
      required this.loading})
      : super(key: key);
  final Function() onResendCode;
  final Function(String val) onCodeChange;
  final Function onConfirm;
  final String code;
  final String phoneNumber;
  final String? error;
  final Function onBack;
  final bool loading;

  @override
  State<ConfirmSlide> createState() => _ConfirmSlideState();
}

class _ConfirmSlideState extends State<ConfirmSlide> {
  List<TextFormField> textForms = [];
  final TextEditingController _controller = TextEditingController();
  List<Card> lists = [];
  List<TextEditingController> controllers = [];
  int countDownMaxNumber = 2;
  int delayed = 500;

  @override
  void initState() {
    countDownMaxNumber = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    delayed = 500;
    return SizedBox(
      height: MediaQuery.of(context).size.height * (10 / 12) - 3,
      child: SingleChildScrollView(
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
                      'Enter code sent \nto your phone',
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
                  delay: delayed -= 180,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'We sent it to the number ${widget.phoneNumber}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                DelayedAnimation(
                  delay: delayed - 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.number,
                        controller: _controller,
                        onChanged: (val) {
                          widget.onCodeChange(val.trim());
                        },
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DelayedAnimation(
                                delay: delayed + 20,
                                child: circle(widget.code, 0)),
                            DelayedAnimation(
                                delay: delayed + 40,
                                child: circle(widget.code, 1)),
                            DelayedAnimation(
                                delay: delayed + 60,
                                child: circle(widget.code, 2)),
                            DelayedAnimation(
                                delay: delayed + 70,
                                child: circle(widget.code, 3)),
                            DelayedAnimation(
                                delay: delayed + 80,
                                child: circle(widget.code, 4)),
                            DelayedAnimation(
                                delay: delayed + 90,
                                child: circle(widget.code, 5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 42.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.error!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                DelayedAnimation(
                  delay: delayed -= 220,
                  child: InkWell(
                    onTap: () {
                      widget.onResendCode();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 24),
                      child: (countDownMaxNumber > 0)
                          ? CountDown(
                              start: countDownMaxNumber,
                              onEnd: () {
                                setState(() {
                                  countDownMaxNumber = 0;
                                });
                              })
                          : InkWell(
                              onTap: () {
                                widget.onResendCode();
                                setState(() {
                                  countDownMaxNumber = 2;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  'Resend a new code.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 14,
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: DelayedAnimation(
                delay: delayed -= 150,
                child: MyKeboard(
                  fontSize: 28,
                  onKeyDown: (char) {
                    if (char.endsWith("back") && widget.code.isNotEmpty) {
                      widget.onCodeChange(
                          widget.code.substring(0, widget.code.length - 1));
                    } else if (char.length == 1) {
                      widget.onCodeChange(widget.code + char);
                    }
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonSizeAnimation(
                  delay: delayed + 500,
                  begin: 0.7,
                  end: 1,
                  milli: 1000,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: BigTextButton(
                      onClick: () {
                        widget.onConfirm();
                      },
                      text: 'Confirm',
                      fontSize: 20,
                      fontWight: FontWeight.bold,
                      backgroudColor: Theme.of(context).colorScheme.secondary,
                      horizontalMargin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      cornerRadius: 22,
                      isLoading: widget.loading,
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
          ],
        ),
      ),
    );
  }

  Widget circle(String c, int num) {
    return InkWell(
      onTap: () {},
      child: Card(
          color: (c.length <= num)
              ? Colors.grey.shade300
              : Theme.of(context)
                  .colorScheme
                  .secondary, //Theme.of(context).colorScheme.secondary,
          shape: const CircleBorder(),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                child: Center(
                  child: Text(c.length > num ? c[num] : '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.white)),
                ),
              ))),
    );
  }

  List<String> _split(String value) {
    String response = value;
    if (value.length < 6) {
      for (int i = 0; i < 6 - value.length; i++) {
        response += ' ';
      }
    } else {
      response = value.substring(0, 6);
    }
    return response.split('');
  }
}
