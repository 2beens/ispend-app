
import 'package:flutter/material.dart';

ThemeData buildDarkTheme() {
  final baseTheme = ThemeData(
    fontFamily: "Open Sans",
  );
  return baseTheme.copyWith(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF143642),
    primaryColorLight: Color(0xFF26667d),
    primaryColorDark: Color(0xFF08161b),
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.white,
  );
}

class CustomTextStyle {
  static TextStyle formField(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle title(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white);
  }

  static TextStyle subTitle(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle button(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle body(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .title
        .copyWith(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);
  }
}
