import 'dart:io';

import 'package:borefts2020/ui/identity/color.dart';
import 'package:flutter/material.dart';

ThemeData boreftsLightTheme() {
  return ThemeData.light().copyWith(
    primaryColor: redDark,
    accentColor: redDark,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      brightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      iconTheme: const IconThemeData(color: Colors.black),
      actionsIconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        title: headerTextStyle(),
      ),
    ),
  );
}

TextStyle headerTextStyle() {
  return const TextStyle(
      fontFamily: 'Monalson', fontSize: 24, color: Colors.black);
}
