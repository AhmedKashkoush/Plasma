import 'package:flutter/material.dart';
import 'package:plasma/Utils/shared_preferences_api.dart';

class ThemeHelper{
  static ThemeMode themeMode = ThemeMode.system;
  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    highlightColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    scaffoldBackgroundColor: Colors.grey.shade200,
    primaryColor: Colors.amber.shade600,
    iconTheme: IconThemeData(color: Colors.grey.shade500),
    useMaterial3: true,
    pageTransitionsTheme: _pageTransitionTheme,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colors.amber.shade600,
      primarySwatch: Colors.amber,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    highlightColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.amber.shade600,
    useMaterial3: true,
    iconTheme: IconThemeData(color: Colors.grey.shade600),
    pageTransitionsTheme: _pageTransitionTheme,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colors.amber.shade600,
      primarySwatch: Colors.amber,
      brightness: Brightness.dark,
    ),
  );

  static Future<void> loadTheme() async{
    final String _themeMode = await SharedPreferencesApi.getString('theme')?? 'system';
    switch (_themeMode){
      case 'light': themeMode = ThemeMode.light;break;
      case 'dark': themeMode = ThemeMode.dark;break;
      default: themeMode = ThemeMode.system;
    }
  }

  static final PageTransitionsTheme _pageTransitionTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    }
  );
}