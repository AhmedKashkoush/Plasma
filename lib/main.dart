import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasma/View/main_screen.dart';
import 'View/before_login.dart';

bool isLogined = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const SystemUiOverlayStyle overlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(overlay);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogined ? const MainScreen() : const BeforeLoginScreen(),
      title: 'Plasma',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        highlightColor: Colors.transparent,
        splashFactory: InkRipple.splashFactory,
        scaffoldBackgroundColor: Colors.grey.shade200,
        primaryColor: Colors.amber,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.amber,
          primarySwatch: Colors.amber,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
