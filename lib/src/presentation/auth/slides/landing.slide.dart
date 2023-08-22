import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../appcore/animations/button.size.animation.dart';
import '../../../appcore/animations/delayed.animation.dart';
import '../../../appcore/widgets/big.text.button.dart';

class LandingSlide extends StatefulWidget {
  const LandingSlide(
      {super.key, required this.onGetStarted, required this.onHaveAccount});
  final Function onGetStarted;
  final Function onHaveAccount;
  @override
  State<LandingSlide> createState() => LandingSlideState();
}

class LandingSlideState extends State<LandingSlide> {
  int delayed = 1600;
  @override
  Widget build(BuildContext context) {
    delayed = 500;
    return SizedBox(
      height: MediaQuery.of(context).size.height * (4 / 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DelayedAnimation(
                  delay: delayed - 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'linko.'.tr, //'Find friends all over the world',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontFamily: 'Malik-Heavy',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
                DelayedAnimation(
                  delay: delayed - 500,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 0),
                    child: Text(
                      "landing_desc".tr, //'Find friends all over the world',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DelayedAnimation(
                delay: delayed -= 100,
                child: InkWell(
                  onTap: () {
                    widget.onHaveAccount();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 10.0, right: 10.0, bottom: 0),
                    child: Text(
                      'already_have_account'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700),
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: delayed -= 150,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '.................................',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 0.0, left: 10, right: 10),
                        child: Text(
                          'or'.tr.capitalize ?? 'Or',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ),
                      Text(
                        '.................................',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ),
              ButtonSizeAnimation(
                delay: delayed,
                begin: 0.7,
                end: 1,
                milli: 1000,
                child: BigTextButton(
                  onClick: () {
                    widget.onGetStarted();
                  },
                  text: 'get_started'.tr,
                  fontSize: 20,
                  backgroudColor: Theme.of(context).colorScheme.secondary,
                  borderColor: Theme.of(context).colorScheme.secondary,
                  fontWight: FontWeight.bold,
                  horizontalMargin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  cornerRadius: 26,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
