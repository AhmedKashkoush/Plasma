import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasma/Model/Models/user_model.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/Utils/notification_helper.dart';
import 'package:plasma/View/Mobile/before_login.dart';
import 'package:plasma/View/Mobile/main_screen.dart';
import 'package:plasma/ViewModel/authentication_view_model.dart';
import 'package:plasma/ViewModel/notifications_view_model.dart';
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
  NotificationsViewModel? vm;

  @override
  void initState() {
    NotificationHelper.onMessageOpenedApp(context);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      FirebaseMessaging.onMessage.listen((message) async{
        _messageHandler(message);
      });
    });
    super.initState();
  }


  void _messageHandler(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification!.android;
    if (notification != null && android != null) {
      vm?.incrementNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel _authVM =
    Provider.of<AuthenticationViewModel>(context,);
    vm = Provider.of<NotificationsViewModel>(context,);
    SystemChrome.setSystemUIOverlayStyle(MobileRootScreen.overlay);
    return isMobileSignedIn ? MainScreen() : const BeforeLoginScreen ();
  }
}
