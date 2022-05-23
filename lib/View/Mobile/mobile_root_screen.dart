import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasma/View/Mobile/before_login.dart';
import 'package:plasma/View/Mobile/main_screen.dart';

class MobileRootScreen extends StatelessWidget {
  const MobileRootScreen({Key? key}) : super(key: key);
  static const SystemUiOverlayStyle overlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // systemNavigationBarColor: Colors.white,
    // systemNavigationBarIconBrightness: Brightness.light,
  );
  static bool isMobileSignedIn = true;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlay);
    return isMobileSignedIn ? const MainScreen() : const BeforeLoginScreen();
  }
}
