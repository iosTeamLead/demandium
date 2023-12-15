import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Ubuntu',
  primaryColor: const Color(0xFF056AB4),
  primaryColorLight: const Color(0xFFF0F4F8),
  primaryColorDark: const Color(0xFF10324A),
  secondaryHeaderColor: const Color(0xFF758493),

  disabledColor: const Color(0xFF8797AB),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  brightness: Brightness.light,
  hintColor: const Color(0xFFC0BFBF),
  focusColor: const Color(0xFFFFF9E5),
  hoverColor: const Color(0xFFF8FAFC),
  shadowColor: Colors.grey[300],
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFF0461A5))),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF056AB4),
    secondary: Color(0xFFFF9900),
    tertiary: Color(0xFFd35221),
    onSecondaryContainer: Color(0xFF02AA05),
    error: Color(0xffed4f55),
    onPrimary: Color(0xFFF8FAFC)
  ).copyWith(background: const Color(0xffFCFCFC)),
);