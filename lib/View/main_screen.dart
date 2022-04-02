import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/notification.dart';
import 'package:plasma/View/profile.dart';

import 'Widgets/custom_drawer.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 1;
  final GlobalKey<CurvedNavigationBarState> _curvedBarKey = GlobalKey<CurvedNavigationBarState>();
  static const List<IconData> _itemIcons = [
    Icons.list,
    Icons.home_rounded,
    Icons.notifications,
    Icons.account_circle_rounded,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(
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
              });
          },
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          index: _index,
          letIndexChange: (index) => index != 0,
          items: _itemIcons
              .map(
                (icon) => GestureDetector(
                  onTap: _itemIcons.indexOf(icon) == 0
                      ? () => Scaffold.of(context).openDrawer()
                      : null,
                  child: Icon(
                    icon,
                    size: 32,
                    color: _index == _itemIcons.indexOf(icon)
                        ? Theme.of(context).primaryColor
                        : Colors.black26,
                  ),
                ),
              )
              .toList(),
        );
      }),
    );
  }
}

class MainScreenItems extends StatelessWidget {
  final int index;
  final GlobalKey<CurvedNavigationBarState> bottomBarKey;
  const MainScreenItems({Key? key, required this.index, required this.bottomBarKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const SizedBox(),
      HomeScreen(bottomBarKey: bottomBarKey,),
      NotificationScreen(bottomBarKey: bottomBarKey,),
      const ProfileScreen(),
    ];
    return IndexedStack(
      children: _screens,
      index: index,
    );
  }
}
