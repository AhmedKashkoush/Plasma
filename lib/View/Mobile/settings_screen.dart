import 'package:flutter/material.dart';
import 'package:plasma/Utils/locales.dart';
import 'package:plasma/Utils/themes.dart';
import 'package:plasma/View/Providers/theme_provider.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';
import 'package:provider/provider.dart';

import '../../Utils/utils.dart';
import '../Providers/localeProvider.dart';
import '../Widgets/mobile_custom_drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static bool _notificationsEnabled = false;

  static Map<String,String> _locales = {
    'en': 'English',
    'ar': 'العربية',
    'fr': 'Français',
  };

  @override
  Widget build(BuildContext context) {
    String? _theme =
        '${ThemeHelper.themeMode.name.characters.first.toUpperCase()}${ThemeHelper.themeMode.name.substring(1)}';
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    Brightness _brightness = Theme.of(context).brightness;
    LocaleProvider _localeProvider = Provider.of<LocaleProvider>(context);
    String languageCode = LocaleHelper.currentLocale?.languageCode.substring(0,2)??'system';
    String _lang = _locales[languageCode]??'System';
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        appBar: AppBar(
          title: TranslatedTextWidget(text: 'Settings'),//Text('Settings'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const MobileCustomDrawer(screenIndex: 6),
        body: ListView(
          children: [
            ListTile(
              title: TranslatedTextWidget(
                text:'Notifications',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: _notificationsEnabled
                  ? Icon(Icons.notifications)
                  : Icon(Icons.notifications_off_sharp),
              onTap: () {},
              trailing: Switch.adaptive(
                value: _notificationsEnabled,
                onChanged: (value) {
                  _notificationsEnabled = value;
                },
                activeColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            ExpansionTile(
              title: TranslatedTextWidget(
                text:'Themes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: TranslatedTextWidget(text: _theme),
              leading: _brightness == Brightness.light
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              children: [
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: TranslatedTextWidget(
                    text:'System',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: 'System',
                  groupValue: _theme,
                  onChanged: (String? value) {
                    _themeProvider.setTheme(ThemeMode.system);
                  },
                ),
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: TranslatedTextWidget(
                    text:'Light',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: 'Light',
                  groupValue: _theme,
                  onChanged: (String? value) {
                    _themeProvider.setTheme(ThemeMode.light);
                  },
                ),
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: TranslatedTextWidget(
                    text:'Dark',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: 'Dark',
                  groupValue: _theme,
                  onChanged: (String? value) {
                    _themeProvider.setTheme(ThemeMode.dark);
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: TranslatedTextWidget(
                text:'Language',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: _lang != 'System'?Text(_lang):TranslatedTextWidget(text: 'System'),
              leading: const Icon(Icons.translate_rounded),
              children: [
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: TranslatedTextWidget(
                    text:'System',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: 'system',
                  groupValue: languageCode,
                  onChanged: (String? value) {
                    _lang = 'System';
                    _localeProvider.setLocale(value!);
                  },
                ),
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: const Text(
                    'العربية',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: 'ar',
                  groupValue: languageCode,
                  onChanged: (String? value) {
                    _lang = _locales[value!]!;
                    _localeProvider.setLocale(value);
                  },
                ),
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: const Text(
                    'English',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: 'en',
                  groupValue: languageCode,
                  onChanged: (String? value) {
                    _lang = _locales[value!]!;
                    _localeProvider.setLocale(value);
                  },
                ),
                RadioListTile(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: const Text(
                    'Français',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: 'fr',
                  groupValue: languageCode,
                  onChanged: (String? value) {
                    _lang = _locales[value!]!;
                    _localeProvider.setLocale(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
