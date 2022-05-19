import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Utils/utils.dart';
import 'package:plasma/View/Mobile/settings_screen.dart';
import 'package:plasma/View/Widgets/selectable_tile.dart';
import 'package:plasma/View/Mobile/benefits.dart';
import 'package:plasma/View/Mobile/conditions.dart';
import 'package:plasma/View/Mobile/contact_us.dart';
import 'package:plasma/View/Mobile/donation_places_screen.dart';
import 'package:plasma/View/Mobile/information.dart';
import 'package:plasma/View/Mobile/main_screen.dart';

class MobileCustomDrawer extends StatelessWidget {
  final int screenIndex;
  final int homeNotifications;

  const MobileCustomDrawer(
      {Key? key, required this.screenIndex, this.homeNotifications = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: DrawerContent(
            itemSelected: screenIndex,
            homeNotifications: homeNotifications,
          ),
        ),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  final int itemSelected;
  final int? homeNotifications;

  const DrawerContent(
      {Key? key, required this.itemSelected, this.homeNotifications})
      : super(key: key);

  static const List<String> _items = [
    'Home Page',
    'What Is Plasma',
    'Benefits Of Plasma Donation',
    'Plasma Donation Conditions',
    'Plasma Donation Places',
    'Contact Us',
    'Settings',
    'About',
  ];

  static const List<IconData> _itemIcons = [
    Icons.home_rounded,
    Icons.water_drop,
    Icons.health_and_safety_rounded,
    Icons.paste_sharp,
    Icons.place_rounded,
    Icons.phone,
    Icons.settings,
    Icons.info_outline,
  ];

  static const List<Widget> _pages = [
    MainScreen(),
    PlasmaInformationScreen(),
    BenefitsScreen(),
    ConditionsScreen(),
    DonationPlacesScreen(),
    ContactUsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Image.asset('images/logo.png', width: 120),
          const SizedBox(
            height: 44,
          ),
          ..._items.map(
            (item) {
              final int index = _items.indexOf(item);
              final List<int> _notifications = [
                homeNotifications!,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
              ];
              return SelectableTile(
                isSelected: index == itemSelected,
                title: item,
                leadingIcon: _itemIcons[_items.indexOf(item)],
                notifications: _notifications[index],
                contentSize: 15,
                onTap: index == itemSelected
                    ? Scaffold.of(context).isDrawerOpen
                        ? () {
                            Navigator.pop(context);
                          }
                        : null
                    : () {
                        Navigator.pop(context);
                        if (index == _items.length - 1) {
                          Utils.showAboutInfoDialog(context);
                          return;
                        }
                        ScaffoldMessenger.of(context)
                            .removeCurrentMaterialBanner();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _pages[index],
                          ),
                        );
                      },
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
