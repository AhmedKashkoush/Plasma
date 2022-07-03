import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Utils/utils.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkWidget extends StatefulWidget {
  final String? text;
  final String link;
  final String? linkText;
  const LinkWidget({Key? key, this.text, required this.link, this.linkText}) : super(key: key);

  @override
  _LinkWidgetState createState() => _LinkWidgetState();
}

class _LinkWidgetState extends State<LinkWidget> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          if (widget.text != null)TextSpan(
            text:
            '${TranslatedTextWidget.translate(widget.text!)} ',
          ),
          TextSpan(
            text: widget.linkText == null?widget.link:widget.linkText,
            style: TextStyle(
              color: Colors.blue,
              backgroundColor:
              isTapped ? Colors.blue.withOpacity(0.4) : null,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (!await launchUrl(
                  Uri.parse(widget.link),
                  mode: LaunchMode.externalApplication,
                )) Utils.showUrlLaunchingError(context);
              }
              ..onTapDown = (details) {
                setState(() {
                  isTapped = true;
                });
              }
              ..onTapUp = (details) {
                setState(() {
                  isTapped = false;
                });
              }
              ..onTapCancel = () {
                setState(() {
                  isTapped = false;
                });
              },
          ),
        ],
      ),
    );
  }
}
