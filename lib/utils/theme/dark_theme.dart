import 'package:flutter/material.dart';
import '../color_resources.dart';

ThemeData dark = ThemeData(
  useMaterial3: false,
  fontFamily: 'Inter',
  primaryColor:  AppColors.primary,
  brightness: Brightness.dark,
  highlightColor: const Color(0xFF252525),
  appBarTheme:  const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFFFFFFF),
    ),
  ),
  hintColor: const Color(0xFFc7c7c7),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);