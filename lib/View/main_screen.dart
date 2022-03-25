import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'Widgets/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 2;
  static const List<IconData> _itemIcons = [
    Icons.account_circle_rounded,
    Icons.notifications,
    Icons.home_rounded,
    Icons.list,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(
        screenIndex: 0,
      ),
      body: MainScreenItems(
        index: _index,
      ),
      bottomNavigationBar: Builder(builder: (context) {
        return CurvedNavigationBar(
          onTap: (index) {
            if (index == 3) return;

            if (index != _index)
              setState(() {
                _index = index;
              });
          },
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          index: _index,
          letIndexChange: (index) => index != 3,
          items: _itemIcons
              .map(
                (icon) => GestureDetector(
                  onTap: _itemIcons.indexOf(icon) == 3
                      ? () => Scaffold.of(context).openEndDrawer()
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
  const MainScreenItems({Key? key, required this.index}) : super(key: key);

  static const List<Widget> _screens = [];

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      children: _screens,
      index: index,
    );
  }
}
