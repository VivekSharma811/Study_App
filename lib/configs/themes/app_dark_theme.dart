import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/sub_theme_data_mixin.dart';

const Color primaryDarkColorDark = Color(0xDD2e3c62);
const Color primaryColorDark = Color(0xFF99ace1);
const Color mainTextColorDark = Colors.white;

class AppDarkTheme with SubThemeData {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      primaryColor: primaryColorDark,
        iconTheme: getIconTheme(),
        textTheme: getTextTheme().apply(
            bodyColor: mainTextColorDark,
            displayColor: mainTextColorDark
        )
    );
  }
}
