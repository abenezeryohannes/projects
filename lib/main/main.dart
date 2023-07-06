import 'dart:async';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../firebase/guards/firebase_options.dart' as FirebaseGuards;
import '../firebase/visitors/firebase_options.dart' as FirebaseVisitors;
import '../src/app.dart';
import '../src/flavors.dart';
import 'injectable/getit.dart';

FutureOr<void> main() async {
  await preRunApp();
  runApp(const App());
}

Future<void> preRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Flutter initialization for auth and messaging
  switch (F.appFlavor) {
    case Flavor.guards:
      await Firebase.initializeApp(
          options: FirebaseVisitors.DefaultFirebaseOptions.currentPlatform);

      break;
    case Flavor.visitors:
      await Firebase.initializeApp(
          options: FirebaseGuards.DefaultFirebaseOptions.currentPlatform);

      break;
    default:
      await Firebase.initializeApp(
          options: FirebaseVisitors.DefaultFirebaseOptions.currentPlatform);
  }

  // Loads contents from .env into memory.
  await dotenv.load();

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

  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
}
