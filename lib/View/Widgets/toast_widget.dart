import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget {
  static void showToast(BuildContext context,{required String msg,}) {
    final Color toastColor = Theme.of(context).scaffoldBackgroundColor;
    final Color toastForeground = Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white;
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: toastColor,
      textColor: toastForeground,
      gravity: ToastGravity.BOTTOM,
    );
  }
}