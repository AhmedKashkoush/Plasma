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
import 'package:plasma/ViewModel/notifications_view_model.dart';
import 'package:provider/provider.dart';

class MobileCustomDrawer extends StatelessWidget {
  final int screenIndex;

  const MobileCustomDrawer(
      {Key? key, required this.screenIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationsViewModel vm = Provider.of<NotificationsViewModel>(context);
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: DrawerContent(
            itemSelected: screenIndex,
            homeNotifications: vm.newNotifications,
          ),
        ),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  final int itemSelected;
  final int homeNotifications;

  const DrawerContent(
      {Key? key, required this.itemSelected,this.homeNotifications = 0})
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

  //static int homeNotifications = AuthHelper.currentUser?.notifications?["new_notifications"];

  @override
  Widget build(BuildContext context) {
    //if (homeNotifications < 0) homeNotifications = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Image.asset('assets/images/logo.png', width: 120),
          const SizedBox(
            height: 44,
          ),
          ..._items.map(
            (item) {
              final int index = _items.indexOf(item);
              final List<int> _notifications = [
                homeNotifications,
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
                    ? Navigator.of(context).canPop()
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
