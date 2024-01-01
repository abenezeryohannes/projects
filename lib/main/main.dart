import 'dart:async';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../firebase/guards/firebase_options.dart' as FirebaseGuards;
import '../firebase/residents/firebase_options.dart' as FirebaseResidents;
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
  switch (FFF.appFlavor) {
    case Flavor.guards:
      await Firebase.initializeApp(
          options: FirebaseResidents.DefaultFirebaseOptions.currentPlatform);

      break;
    case Flavor.residents:
      await Firebase.initializeApp(
          options: FirebaseGuards.DefaultFirebaseOptions.currentPlatform);

      break;
    default:
      await Firebase.initializeApp(
          options: FirebaseResidents.DefaultFirebaseOptions.currentPlatform);
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

  //
  //
  //
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCMToken $fcmToken");
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
