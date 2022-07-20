import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/Utils/notification_helper.dart';
import 'package:plasma/Utils/onboarding_pref.dart';
import 'package:plasma/View/Mobile/before_login.dart';
import 'package:plasma/View/Mobile/main_screen.dart';
import 'package:plasma/View/Mobile/onboarding_screen.dart';
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

class _MobileRootScreenState extends State<MobileRootScreen> with WidgetsBindingObserver{
  bool isMobileSignedIn = AuthHelper.currentUser != null;
  NotificationsViewModel? vm;

  @override
  void initState() {
    NotificationHelper.onMessageOpenedApp(context);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      WidgetsBinding.instance?.addObserver(this);
      if (AuthHelper.currentUser != null) vm?.getNewNotifications();
      FirebaseMessaging.onMessage.listen(_messageHandler);
    });
    super.initState();
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification!.android;
    if (notification != null && android != null) {
      if (AuthHelper.currentUser == null) return;
      vm?.incrementNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthenticationViewModel>(context);
    vm = Provider.of<NotificationsViewModel>(context);
    SystemChrome.setSystemUIOverlayStyle(MobileRootScreen.overlay);
    bool skipped = OnBoardingPref.skippedOnBoarding;
    if (!skipped) return const OnBoardingScreen();
    return isMobileSignedIn ? const MainScreen() : const BeforeLoginScreen();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) vm?.getNewNotifications();
    super.didChangeAppLifecycleState(state);
  }
}
