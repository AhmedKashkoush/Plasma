import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasma/Utils/locales.dart';

class TranslatedTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  TranslatedTextWidget({Key? key, required this.text, this.style, this.textAlign, this.maxLines})
      : super(key: key);

  @override
  State<TranslatedTextWidget> createState() => _TranslatedTextWidgetState();

  static Map<String, dynamic>? _englishMap;
  static String translate(String text){
    String? _key;
    final Map<String, dynamic>? _locale = LocaleHelper.activeLocale;
    String? englishFile =
        LocaleHelper.englishFile;
    _englishMap = jsonDecode(englishFile!);
    _englishMap?.keys.forEach((key) {
      if (_englishMap![key] == text) {
        _key = key;
        return;
      }
    });
    String _translatedText = _locale![_key]??'Error translating text';
    return _translatedText;
  }
}

class _TranslatedTextWidgetState extends State<TranslatedTextWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      TranslatedTextWidget.translate(widget.text),
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
    );
  }
  // TranslatedTextWidget(
  // text:
}
