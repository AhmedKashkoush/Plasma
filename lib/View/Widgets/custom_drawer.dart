import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/Widgets/selectable_tile.dart';
import 'package:plasma/View/benefits.dart';
import 'package:plasma/View/conditions.dart';
import 'package:plasma/View/contact_us.dart';
import 'package:plasma/View/donation_places_screen.dart';
import 'package:plasma/View/information.dart';
import 'package:plasma/View/main_screen.dart';

class CustomDrawer extends StatelessWidget {
  final int screenIndex;
  const CustomDrawer({Key? key, required this.screenIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: DrawerContent(
            itemSelected: screenIndex,
          ),
        ),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  final int itemSelected;
  const DrawerContent({Key? key, required this.itemSelected}) : super(key: key);

  static const List<String> _items = [
    'Home Page',
    'What Is Plasma',
    'Benefits Of Plasma Donation',
    'Plasma Donation Conditions',
    'Plasma Donation Places',
    'Contact Us',
  ];

  static const List<IconData> _itemIcons = [
    Icons.home_rounded,
    Icons.water_drop,
    Icons.health_and_safety_rounded,
    Icons.paste_sharp,
    Icons.place_rounded,
    Icons.phone,
  ];

  static const List<Widget> _pages = [
    MainScreen(),
    PlasmaInformationScreen(),
    BenefitsScreen(),
    ConditionsScreen(),
    DonationPlacesScreen(),
    ContactUsScreen(),
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
              return SelectableTile(
                isSelected: index == itemSelected,
                title: item,
                leadingIcon: _itemIcons[_items.indexOf(item)],
                contentSize: 15,
                onTap: index == itemSelected
                    ? null
                    : () {
                        Navigator.pop(context);
                        Navigator.push(
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
