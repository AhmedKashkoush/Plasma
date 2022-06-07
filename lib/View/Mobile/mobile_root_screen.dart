import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasma/Model/Models/user_model.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/View/Mobile/before_login.dart';
import 'package:plasma/View/Mobile/main_screen.dart';
import 'package:plasma/ViewModel/authentication_view_model.dart';
import 'package:provider/provider.dart';

class MobileRootScreen extends StatefulWidget {
  const MobileRootScreen({Key? key}) : super(key: key);
  static const SystemUiOverlayStyle overlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // systemNavigationBarColor: Colors.white,
    // systemNavigationBarIconBrightness: Brightness.light,
  );

  @override
  State<MobileRootScreen> createState() => _MobileRootScreenState();
}

class _MobileRootScreenState extends State<MobileRootScreen> {
  bool isMobileSignedIn = AuthHelper.currentUser != null;

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel _authVM =
    Provider.of<AuthenticationViewModel>(context,);
    SystemChrome.setSystemUIOverlayStyle(MobileRootScreen.overlay);
    return isMobileSignedIn ? MainScreen() : const BeforeLoginScreen();
  }
}
