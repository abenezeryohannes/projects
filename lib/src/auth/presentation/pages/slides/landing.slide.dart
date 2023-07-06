import 'package:flutter/material.dart';
import 'package:rnginfra/src/core/animations/getstarted/button.size.animation.dart';

import '../../../../core/animations/delayed.animation.dart';
import '../../../../core/widgets/big.text.button.dart';

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
          DelayedAnimation(
            delay: delayed - 400,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
              child: Text(
                'RNG Supra Avenue security', //'Find friends all over the world',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w400,
                    fontSize: 28),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonSizeAnimation(
                delay: delayed,
                begin: 0.7,
                end: 1,
                milli: 1000,
                child: BigTextButton(
                  onClick: () {
                    widget.onGetStarted();
                  },
                  text: 'Get Started',
                  fontSize: 20,
                  fontWight: FontWeight.bold,
                  horizontalMargin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  cornerRadius: 22,
                ),
              ),
              DelayedAnimation(
                delay: delayed -= 150,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: .0),
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
                          'Or',
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
                      'Already have an account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
