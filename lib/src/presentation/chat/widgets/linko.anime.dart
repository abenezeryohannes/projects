import 'dart:async';

import 'package:flutter/material.dart';

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
            _currentTxt = _completeTxt.substring(
                (_completeTxt.length - 1) - (_currentTxt.length),
                _completeTxt.length);
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _opacityLogo() async {
    int _count = 0;
    Timer.periodic(const Duration(milliseconds: 1200), (timer) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
              duration: const Duration(seconds: 1),
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
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
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
