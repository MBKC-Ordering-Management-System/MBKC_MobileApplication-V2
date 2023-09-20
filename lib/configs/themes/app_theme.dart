import 'package:flutter/material.dart';
import '../../utils/constants/asset_constant.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: AssetsConstants.scaffoldColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AssetsConstants.whiteColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AssetsConstants.mainColor,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AssetsConstants.mainColor,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AssetsConstants.whiteColor,
      labelStyle: TextStyle(color: Colors.pink[800]), // color for text
      indicator: const UnderlineTabIndicator(
          // color for indicator (underline)
          borderSide: BorderSide(color: AssetsConstants.mainColor)),
    ),
    primaryColor:
        AssetsConstants.mainColor, // outdated and has no effect to Tabbar
    // deprecated,
  );
}
