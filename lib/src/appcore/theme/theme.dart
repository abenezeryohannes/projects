import 'package:flutter/material.dart';

//accent EA3557
ThemeData LightThemeData = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFFEA3557),
    textTheme: const TextTheme(
        labelLarge: TextStyle(
            // color: Color(0xFFEA3557),
            )),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    cardColor: const Color(0xFFF4F4F4),
    highlightColor: Colors.grey.shade300,
    colorScheme: const ColorScheme.light(
      secondary: Color(0xFFEA3557),
      onSecondary: Color(0xFFFFFFFF),
      onBackground: Color(0xFF333333),
      background: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      primary: Color(0xFFEA3557),
      primaryContainer: Color(0XFFEA3557),
      onPrimaryContainer: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFFFFFFFF),
    ));

ThemeData DarkThemeData = ThemeData(
    useMaterial3: true,
    highlightColor: Colors.grey.shade700,
    primaryColor: const Color(0xFFEA3557),
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.black54)),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF212121),
    cardColor: const Color(0xFF212121),
    colorScheme: const ColorScheme.light(
      onTertiary: Color(0xFFEA3557),
      secondary: Color(0xFFEA3557),
      onSecondary: Color(0xFFFFFFFF),
      onBackground: Color(0xFFFFFFFF),
      background: Color(0xFF3d3d3d),
      onPrimary: Color(0xFFFFFFFF),
      primary: Color(0xFFEA3557),
      primaryContainer: Color(0XFFEA3557),
      onPrimaryContainer: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFF212121),
    ));
