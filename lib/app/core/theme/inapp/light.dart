import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../light.dart';

final CustomLightTheme _lightTheme = CustomLightTheme();

final ThemeData lightThemeData = ThemeData(
  fontFamily: 'SUITv1',
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _lightTheme.colors.coreAccent,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    titleSpacing: 0,
    foregroundColor: _lightTheme.colors.contentStandardPrimary,
    centerTitle: false,
  ),
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: _lightTheme.colors.coreAccent.withAlpha(100),
      selectionHandleColor: _lightTheme.colors.coreAccent),
  cupertinoOverrideTheme:
      CupertinoThemeData(primaryColor: _lightTheme.colors.coreAccent),
  scaffoldBackgroundColor: _lightTheme.colors.backgroundStandardPrimary,
  extensions: [_lightTheme.colors, _lightTheme.textStyle],
  cardColor: _lightTheme.colors.componentsFillStandardPrimary,
);
