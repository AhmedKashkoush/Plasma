import 'package:flutter/cupertino.dart';

class QuestionScreenProvider extends ChangeNotifier{
  String selectedCenter = '';

  void setCenter(String name){
    selectedCenter = name;
    notifyListeners();
  }
}