import 'package:flutter/material.dart';
import 'package:plasma/Utils/themes.dart';
import 'package:plasma/View/Providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../Widgets/mobile_custom_drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static bool _notificationsEnabled = false;
  static String? _lang = 'System';
  @override
  Widget build(BuildContext context) {
    String? _theme = '${ThemeHelper.themeMode.name.characters.first.toUpperCase()}${ThemeHelper.themeMode.name.substring(1)}';
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    Brightness _brightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MobileCustomDrawer(screenIndex: 6),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Notifications',style: TextStyle(fontWeight: FontWeight.bold),),
            leading: _notificationsEnabled?Icon(Icons.notifications):Icon(Icons.notifications_off_sharp),
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
            title: const Text('Themes',style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(_theme),
            leading: _brightness == Brightness.light?const Icon(Icons.light_mode):const Icon(Icons.dark_mode),
            children: [
              RadioListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: const Text('System',style: TextStyle(fontWeight: FontWeight.bold),),
                value: 'System',
                groupValue: _theme,
                onChanged: (String? value) {
                  _themeProvider.setTheme(ThemeMode.system);
                },
              ),
              RadioListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: const Text('Light',style: TextStyle(fontWeight: FontWeight.bold),),
                value: 'Light',
                groupValue: _theme,
                onChanged: (String? value) {
                  _themeProvider.setTheme(ThemeMode.light);
                },
              ),
              RadioListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: const Text('Dark',style: TextStyle(fontWeight: FontWeight.bold),),
                value: 'Dark',
                groupValue: _theme,
                onChanged: (String? value) {
                  _themeProvider.setTheme(ThemeMode.dark);
                },
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Language',style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(_lang!),
            leading: const Icon(Icons.translate_rounded),
            children: [
              RadioListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: const Text('System',style: TextStyle(fontWeight: FontWeight.bold),),
                value: 'System',
                groupValue: _lang,
                onChanged: (String? value) {
                  _lang = value;
                },
              ),
              RadioListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: const Text('العربية',style: TextStyle(fontWeight: FontWeight.bold),),
                value: 'العربية',
                groupValue: _lang,
                onChanged: (String? value) {
                  _lang = value;
                },
              ),
              RadioListTile(
                activeColor: Theme.of(context).colorScheme.secondary,
                title: const Text('English',style: TextStyle(fontWeight: FontWeight.bold),),
                value: 'English',
                groupValue: _lang,
                onChanged: (String? value) {
                  _lang = value;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

