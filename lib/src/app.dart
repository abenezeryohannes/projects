import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rnginfra/main/themes/themes.dart';
import 'package:rnginfra/src/auth/presentation/pages/auth.page.dart';
import 'package:rnginfra/src/guards/guard.main.page.dart';
import 'package:rnginfra/src/residents/visitors/presentation/residents.main.page.dart';
import 'flavors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: (FFF.appFlavor == Flavor.residents)
            ? lightResidentThemeData
            : lightDriverThemeData,
        builder: (context, myTheme) {
          return GetMaterialApp(
            title: FFF.title,
            theme: (FFF.appFlavor == Flavor.residents)
                ? lightResidentThemeData
                : lightDriverThemeData,
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
                : (Flavor.residents == FFF.appFlavor)
                    ? const ResidentMainPage()
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
              message: FFF.name,
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
