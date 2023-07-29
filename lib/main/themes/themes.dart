import 'package:flutter/material.dart';

//#C7D8D3
//#94B3AA
//#3F7566
//#044331
//#013425

ThemeData lightDriverThemeData = ThemeData(
    primaryColor: const Color(0xFF59705C),
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.white70)),
    brightness: Brightness.light,
    cardColor: const Color(0xFFF4F4F4),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: const ColorScheme.light(
      secondary: Color(0xFF59705C),
      onSecondary: Color(0xFFFFFFFF),
      onBackground: Color(0xFF0A1D23),
      background: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      primary: Color(0xFF59705C),
      primaryContainer: Color(0XFF375D3B),
      onPrimaryContainer: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFFFFFFFF),
    ));
// ThemeData lightDriverThemeData = ThemeData(
//     primaryColor: const Color(0xFF395873),
//     textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.white70)),
//     brightness: Brightness.light,
//     cardColor: const Color(0xFFF4F4F4),
//     scaffoldBackgroundColor: const Color(0xFFFFFFFF),
//     colorScheme: const ColorScheme.light(
//       secondary: Color(0xFF395873),
//       onSecondary: Color(0xFFFFFFFF),
//       onBackground: Color(0xFF395873),
//       background: Color(0xFFFFFFFF),
//       onPrimary: Color(0xFFFFFFFF),
//       primary: Color(0xFF395873),
//       primaryContainer: Color(0xFF395873),
//       onPrimaryContainer: Color(0xFFFFFFFF),
//       onSecondaryContainer: Color(0xFFFFFFFF),
//     ));

ThemeData darkDriverThemeData = ThemeData(
    primaryColor: Colors.blue,
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.black54)),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark());

ThemeData lightThemeData = ThemeData(
    primaryColor: Colors.blue,
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.white70)),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light());

ThemeData darkThemeData = ThemeData(
    primaryColor: Colors.blue,
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.black54)),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark());
