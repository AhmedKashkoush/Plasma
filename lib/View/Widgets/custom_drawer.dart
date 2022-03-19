import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/Widgets/selectable_tile.dart';

class CustomDrawer extends StatelessWidget {
  final Widget checkWidgetType;
  const CustomDrawer({Key? key, required this.checkWidgetType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: const DrawerContent(
            itemSelected: 0,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Image.asset('images/logo.png',width: 120),
          const SizedBox(height: 44,),
          ..._items
              .map(
                (item) => SelectableTile(
                  isSelected: _items.indexOf(item) == itemSelected,
                  title: item,
                  leadingIcon: _itemIcons[_items.indexOf(item)],
                  contentSize: 15,
                  onTap: () {},
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
