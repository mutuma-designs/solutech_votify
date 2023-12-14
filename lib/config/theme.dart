import 'package:flutter/material.dart';
import 'package:flutter_screwdriver/flutter_screwdriver.dart';
import 'package:solutech_votify/config/styles.dart';

final lightTheme = ThemeData(
  primaryColor: const Color(0xff1176BC),
  brightness: Brightness.light,
  dividerColor: Colors.grey.shade200,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0.0,
    //color: Colors.black,
    //foregroundColor: const Color(0xffFF5E00),
    titleTextStyle: TextStyle(
      color: Colors.black54,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      color: Color(0xff565765),
    ),
    isDense: true,
    filled: true,
    fillColor: Colors.grey.shade100,
    border: defaultInputBorder,
    enabledBorder: defaultInputBorder,
    focusedBorder: defaultInputBorder,
  ),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: const Color(0xff1176BC).toMaterialColor(),
  ).copyWith(
    secondary: const Color(0xff1176BC),
  ),
);
