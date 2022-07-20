import 'package:flutter/material.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class RoundedHeader extends StatelessWidget {
  final String text;
  final Widget? icon;
  final double? height;
  final Color? color;

  const RoundedHeader(
      {Key? key, required this.text, this.icon, this.height, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? double.infinity,
      //margin: const EdgeInsets.only(bottom: 20),
      //padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (icon != null) icon!,
          if (text != '')
            TranslatedTextWidget(
              text: text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }
}
