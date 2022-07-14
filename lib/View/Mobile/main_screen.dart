import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Utils/utils.dart';
import 'package:plasma/View/Mobile/notification.dart';
import 'package:plasma/View/Mobile/profile.dart';
import 'package:plasma/ViewModel/notifications_view_model.dart';
import 'package:provider/provider.dart';

import '../Widgets/mobile_custom_drawer.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 1;
  late int _notificationsNumber; //AuthHelper.currentUser?.notifications?["new_notifications"] > 0? AuthHelper.currentUser?.notifications!["new_notifications"]: 0;
  final GlobalKey<CurvedNavigationBarState> _curvedBarKey =
      GlobalKey<CurvedNavigationBarState>();
  static const List<IconData> _itemIcons = [
    Icons.list,
    Icons.home_rounded,
    Icons.notifications,
    Icons.account_circle_rounded,
  ];

//   void _messageHandler(RemoteMessage message) async {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification!.android;
//       if (notification != null && android != null) {
//         if (_index != 2) vm?.incrementNotifications();
//       }
//   }
//
//
//   @override
//   void initState() {
//     FirebaseMessaging.onMessage.listen((message) async{
//       _messageHandler(message);
//     });
//     super.initState();
//   }
// @override
//   void didChangeDependencies() {
//     vm = Provider.of<NotificationsViewModel>(context);
//     super.didChangeDependencies();
//   }

  @override
  Widget build(BuildContext context) {
    final NotificationsViewModel vm = Provider.of<NotificationsViewModel>(context);
    _notificationsNumber = vm.newNotifications;
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        drawer: MobileCustomDrawer(
          screenIndex: 0,
        ),
        body: MainScreenItems(
              index: _index,
              bottomBarKey: _curvedBarKey,
            ),
        bottomNavigationBar: Builder(builder: (context) {
          return CurvedNavigationBar(
            key: _curvedBarKey,
            onTap: (index) {
              if (index == 0) return;

              if (index != _index)
                setState(() {
                  _index = index;
                  if (_index == 2) vm.flushNotifications();
                });
            },
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            color: Theme.of(context).brightness == Brightness.light? Colors.white:Colors.grey.shade800,
            index: _index,
            letIndexChange: (index) => index != 0,
            items: _itemIcons
                .map(
                  (icon) => GestureDetector(
                    onTap: _itemIcons.indexOf(icon) == 0
                        ? () => Scaffold.of(context).openDrawer()
                        : null,
                    child:
                        _itemIcons.indexOf(icon) == 2 && _notificationsNumber > 0
                            ? Badge(
                                animationType: BadgeAnimationType.scale,
                                elevation: 0,
                                animationDuration: const Duration(milliseconds: 300),
                                position: BadgePosition.topEnd(top: -5,end: -5,),
                                badgeContent: Text(
                                  '$_notificationsNumber',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: Icon(
                                  icon,
                                  size: 32,
                                  color: _index == _itemIcons.indexOf(icon)
                                      ? Theme.of(context).primaryColor
                                      : null,
                                ),
                              )
                            : Icon(
                                icon,
                                size: 32,
                                color: _index == _itemIcons.indexOf(icon)
                                    ? Theme.of(context).primaryColor
                                    : null,
                              ),
                  ),
                )
                .toList(),
          );
        }),
      ),
    );
  }
}

class MainScreenItems extends StatelessWidget {
  final int index;
  final GlobalKey<CurvedNavigationBarState> bottomBarKey;
  const MainScreenItems(
      {Key? key, required this.index, required this.bottomBarKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const SizedBox(),
      HomeScreen(
        bottomBarKey: bottomBarKey,
      ),
      NotificationScreen(
        bottomBarKey: bottomBarKey,
      ),
      const ProfileScreen(),
    ];
    // return IndexedStack(
    //   children: _screens,
    //   index: index,
    // );
    return _screens[index];
  }
}
