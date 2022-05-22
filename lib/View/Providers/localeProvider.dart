import 'package:flutter/material.dart';

import '../../Utils/locales.dart';
import '../../Utils/shared_preferences_api.dart';

class LocaleProvider extends ChangeNotifier {
  void setLocale(String languageCode) async{
    await LocaleHelper.setLocale(languageCode);
    SharedPreferencesApi.setString('locale', languageCode);
    notifyListeners();
  }
}
