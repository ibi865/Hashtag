import 'package:flutter/material.dart';

import '../color_resources.dart';

ThemeData light = ThemeData(
  useMaterial3: false,
  fontFamily: 'Inter',
  primaryColor: Colors.white,
  primaryColorDark: AppColors.primary,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  highlightColor: Colors.white,
  hintColor: const Color(0xFF9E9E9E),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFF742E)),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
    titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.red),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black),
  ),
);

