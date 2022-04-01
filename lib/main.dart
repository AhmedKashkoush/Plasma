import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasma/View/home.dart';
import 'package:plasma/View/information.dart';
import 'View/conditions.dart';
import 'View/before_login.dart';

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

      // home:  home(),
            //home: ConditionsScreen(),
      title: 'Plasma',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        highlightColor: Colors.transparent,
        splashFactory: InkRipple.splashFactory,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.amber,
          primarySwatch: Colors.amber,
        ),
      ),
    );
  }
}
