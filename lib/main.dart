import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  const SystemUiOverlayStyle overlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
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
      title: 'Plasma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.amber,
        primarySwatch: Colors.amber,
      )),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plasma Start'),
      ),
    );
  }
}
