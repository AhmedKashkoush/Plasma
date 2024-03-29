import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/Utils/centers_locations.dart';
import 'package:plasma/Utils/locales.dart';
import 'package:plasma/Utils/notification_helper.dart';
import 'package:plasma/Utils/onboarding_pref.dart';
import 'package:plasma/Utils/themes.dart';
import 'package:plasma/View/Mobile/mobile_root_screen.dart';
import 'package:plasma/ViewModel/authentication_view_model.dart';
import 'package:plasma/ViewModel/notifications_view_model.dart';
import 'package:plasma/ViewModel/reservation_view_model.dart';
import 'package:provider/provider.dart';

import 'Utils/shared_preferences_api.dart';
import 'View/Providers/localeProvider.dart';
import 'View/Providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'plasma',
    options: FirebaseOptions(
      apiKey: "AIzaSyDPzvjtXUhK21PNzHGdwtUk2DvQgMGtPfs",
      authDomain: "plasma-fecd2.firebaseapp.com",
      projectId: "plasma-fecd2",
      storageBucket: "plasma-fecd2.appspot.com",
      messagingSenderId: "951530390148",
      appId: "1:951530390148:web:05340ef570b71e7cc038d1",
    ),
  );
  await NotificationHelper.messageHandler();
  FirebaseMessaging.onBackgroundMessage(NotificationHelper.backgroundMessageHandler);
  await SharedPreferencesApi.init();
  await ThemeHelper.loadTheme();
  await LocaleHelper.loadLocale();
  await OnBoardingPref.hasSkippedOnBoarding();
  await AuthHelper.getUserData();
  await CentersLocations.loadLocations();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthenticationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReservationViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);
    Provider.of<LocaleProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MobileRootScreen(),
      title: 'Plasma',
      theme: ThemeHelper.lightTheme,
      darkTheme: ThemeHelper.darkTheme,
      themeMode: ThemeHelper.themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: LocaleHelper.currentLocale,
      supportedLocales: LocaleHelper.supportedLocales,
      localeResolutionCallback: (current, supported) {
        for (Locale locale in supported) {
          if (locale.languageCode == current?.languageCode) return locale;
        }
        return supported.first;
      },
    );
  }
}
