import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class LinkoAnime extends StatefulWidget {
  const LinkoAnime({super.key});

  @override
  State<LinkoAnime> createState() => _LinkoAnimeState();
}

class _LinkoAnimeState extends State<LinkoAnime> {
  final String _completeTxt = 'Linko.';
  String _currentTxt = '';
  double _opacity = 0;
  double _txtOpacity = 0;

  void _opacityTxt() async {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_currentTxt.length < _completeTxt.length) {
        setState(() {
          _txtOpacity = 1;
          if (_txtOpacity == 1) {
            // _currentTxt = _completeTxt.substring(
            //     (_completeTxt.length - 1) - (_currentTxt.length),
            //     _completeTxt.length);
            _currentTxt = _completeTxt.substring(
                0,
                ((_completeTxt.length) -
                    (_completeTxt.length - _currentTxt.length) +
                    1));
          }
        });
        vibrateNow();
      } else {
        timer.cancel();
      }
    });
  }

  void _opacityLogo() async {
    int _count = 0;
    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (++_count <= 5) {
        setState(() {
          _opacity = (_opacity == 1) ? 0 : 1;
        });
      }
      if (_count == 5) {
        _opacityTxt();
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => animate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // textDirection: TextDirection.ltr,
          children: [
            AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: _opacity,
                child: Image.asset(
                  'assets/icon/logo.png',
                  width: 42,
                  height: 42,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _txtOpacity,
                child: Text(
                  _currentTxt,
                  textDirection: TextDirection.ltr,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.black,
                      fontFamily: 'Malik-Heavy',
                      fontSize: 32,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  vibrateNow() async {
    var _type = FeedbackType.heavy;
    Vibrate.feedback(_type);
  }

  void animate() {
    if (_opacity == 1) {
      setState(() {
        _opacity = 0;
        _currentTxt = '';
      });
    } else {
      _opacityLogo();
    }
  }
}
