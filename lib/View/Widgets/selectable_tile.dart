import 'package:flutter/material.dart';

class SelectableTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;
  final String title;
  final String? subTitle;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double contentSize;
  const SelectableTile(
      {Key? key,
      this.isSelected = false,
      this.onTap,
      required this.title,
      this.subTitle,
      this.leadingIcon,
      this.trailingIcon,
      this.contentSize = 14})
      : super(key: key);

  static const Radius _radius = Radius.circular(26);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: _radius,
            bottomRight: _radius,
          ),
        ),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : null,
                  fontSize: contentSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(subTitle ?? ''),
              leading: Icon(
                leadingIcon,
                color: isSelected ? Colors.white : null,
                size: contentSize+10,
              ),
              trailing: Icon(
                trailingIcon,
                color: isSelected ? Colors.white : null,
                size: contentSize+10,
              ),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
