import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linko/injectable/getit.dart';
import 'package:linko/src/appcore/language/localizations.dart' as localizations;
import 'package:linko/src/presentation/chat/chat.page.dart';
import 'package:linko/src/appcore/theme/theme.dart';
import 'firebase_options.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init();
  // await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Locks app orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Makes the device's app bar and bottom navigation bar visible
  // because 'flutter_native_splash.yaml' renders a full screen splash screen,
  // thereby hiding both elements
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  //Setting SysemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.grey.shade200,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.grey.shade500,
      statusBarIconBrightness: Brightness.dark));

  //Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  configureDependencies();
  // Loads contents from .env into memory.
  await dotenv.load();

  runApp(const MyApp());
  // runApp(ProviderScope(
  //   child: EasyLocalization(
  //       supportedLocales: const [Locale('en', 'US'), Locale('ar', 'KW')],
  //       path:
  //           'assets/translations', // <-- change the path of the translation files
  //       fallbackLocale: const Locale('en', 'US'),
  //       child: const MyApp()),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = GetStorage().read('lang');
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      translations: localizations.Localizations(),
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('ar', 'KW'), // Spanish
      ],
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      locale:
          lang == 'ar' ? const Locale('ar', 'KW') : const Locale('en', 'US'),
      theme: LightThemeData,
      home: const ChatPage(),
    );
  }
}
