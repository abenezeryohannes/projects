import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rnginfra/main/themes/themes.dart';
import 'package:rnginfra/src/auth/presentation/pages/auth.page.dart';
import 'package:rnginfra/src/guards/core/presentation/guard.main.page.dart';
import 'flavors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: lightDriverThemeData,
        builder: (context, myTheme) {
          return MaterialApp(
            title: F.title,
            theme: lightDriverThemeData,
            debugShowCheckedModeBanner: false,
            home: FirebaseAuth.instance.currentUser == null
                ? AuthPage(
                    onAuthentication: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GuardMainPage()));
                    },
                  )
                : const GuardMainPage(),
          );
        });
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = false,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
