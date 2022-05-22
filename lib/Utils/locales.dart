import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:plasma/Utils/shared_preferences_api.dart';

class LocaleHelper {
  static Locale? currentLocale;
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('fr'),
  ];

  static String? englishFile;

  static Map<String, dynamic>? activeLocale;

  static Future<void> loadLocale() async {
    englishFile = await rootBundle.loadString('assets/languages/en.json');
    String languageCode =
        await SharedPreferencesApi.getString('locale') ?? 'system';
    setLocale(languageCode);
  }

  static Future<void> setLocale(String languageCode) async {
    if (languageCode == 'system') {
      currentLocale = null;
      String systemLocaleName = Platform.localeName.substring(0, 2);
      if (supportedLocales.contains(Locale(systemLocaleName)))
        await getLocaleFile(systemLocaleName);
      else
        await getLocaleFile(
            supportedLocales.first.languageCode.substring(0, 2));
      return;
    }
    currentLocale = Locale(languageCode);
    for (Locale supportedLocale in supportedLocales) {
      if (languageCode == supportedLocale.languageCode.substring(0, 2)) {
        await getLocaleFile(languageCode);
        return;
      }
    }
    await getLocaleFile(supportedLocales.first.languageCode.substring(0, 2));
  }

  static Future<void> getLocaleFile(String languageCode) async {
    String languageFile =
        await rootBundle.loadString('assets/languages/$languageCode.json');
    activeLocale = jsonDecode(languageFile);
  }
}
