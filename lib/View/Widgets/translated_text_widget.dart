import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plasma/Utils/locales.dart';

class TranslatedTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  TranslatedTextWidget(
      {Key? key, required this.text, this.style, this.textAlign, this.maxLines, this.overflow})
      : super(key: key);

  @override
  State<TranslatedTextWidget> createState() => _TranslatedTextWidgetState();

  ///Matches the given text with the default english json file values then translates to the current locale.
  ///
  ///The optional parameter [locale] if not null the method translates the text to this locale, active locale otherwise.
  static String translate(String text, [String? locale]) {
    String? _key;
    final Map<String, dynamic>? _locale = LocaleHelper.activeLocale;
    final Map<String, dynamic>? _allLocales = LocaleHelper.localeMap;
    Map<String, dynamic>? _englishMap;
    String? englishFile = LocaleHelper.englishFile;
    _englishMap = jsonDecode(englishFile!);
    _englishMap?.keys.forEach((key) {
      if (_englishMap![key] == text) {
        _key = key;
        return;
      }
    });
    String _translatedText = locale != null
        ? _allLocales
        : _locale![_key] ?? 'Error translating text';
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
      overflow: widget.overflow,
    );
  }
// TranslatedTextWidget(
// text:
}
