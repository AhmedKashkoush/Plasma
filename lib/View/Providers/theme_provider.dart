import 'package:flutter/material.dart';
import 'package:plasma/Utils/shared_preferences_api.dart';
import 'package:plasma/Utils/themes.dart';

class ThemeProvider extends ChangeNotifier{
  void setTheme(ThemeMode themeMode){
    ThemeHelper.themeMode = themeMode;
    SharedPreferencesApi.setString('theme', ThemeHelper.themeMode.name);
    notifyListeners();
  }
}