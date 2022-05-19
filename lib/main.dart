import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Utils/themes.dart';
import 'package:plasma/View/Mobile/mobile_root_screen.dart';
import 'package:provider/provider.dart';

import 'Utils/shared_preferences_api.dart';
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
  await SharedPreferencesApi.init();
  await ThemeHelper.loadTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MobileRootScreen(),
      title: 'Plasma',
      theme: ThemeHelper.lightTheme,
      darkTheme: ThemeHelper.darkTheme,
      themeMode: ThemeHelper.themeMode,
    );
  }
}
