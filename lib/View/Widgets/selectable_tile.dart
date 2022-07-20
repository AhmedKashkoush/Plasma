import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class SelectableTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;
  final String title;
  final String? subTitle;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final int? notifications;
  final double contentSize;

  const SelectableTile({
    Key? key,
    this.isSelected = false,
    this.onTap,
    required this.title,
    this.subTitle,
    this.leadingIcon,
    this.trailingIcon,
    this.contentSize = 14,
    this.notifications,
  }) : super(key: key);

  static const Radius _radius = Radius.circular(26);

  @override
  Widget build(BuildContext context) {
    bool isLTR = Directionality.of(context) == TextDirection.ltr;
    return Padding(
      padding: EdgeInsets.only(right: isLTR ? 20 : 0, left: isLTR ? 0 : 20),
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: isLTR
              ? BorderRadius.only(
                  topRight: _radius,
                  bottomRight: _radius,
                )
              : BorderRadius.only(
                  topLeft: _radius,
                  bottomLeft: _radius,
                ),
        ),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              title: TranslatedTextWidget(
                text: title,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).scaffoldBackgroundColor
                      : null,
                  fontSize: contentSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(subTitle ?? ''),
              leading: Icon(
                leadingIcon,
                color: isSelected
                    ? Theme.of(context).scaffoldBackgroundColor
                    : null,
                size: contentSize + 10,
              ),
              trailing: notifications == null || notifications == 0
                  ? Icon(
                      trailingIcon,
                      color: isSelected
                          ? Theme.of(context).scaffoldBackgroundColor
                          : null,
                      size: contentSize + 10,
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Badge(
                        padding: const EdgeInsets.all(6),
                        elevation: 0,
                        toAnimate: false,
                        badgeContent: Text(
                          '$notifications',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
