import 'package:flutter/material.dart';

class QuestionScreenProvider extends ChangeNotifier{
  String centerName = '';
  String centerAddress = '';
  String centerGov = '';
  List<String> _answeredQuestions = [];

  List<String> get answeredQuestions => _answeredQuestions;

  void setCenter(String name){
    List<String> center = name.split(';');
    centerName = center[0];
    centerAddress = center[1];
    centerGov = center[2];
    notifyListeners();
  }

  void setAnswer(String answer){
    _answeredQuestions.add(answer);
  }

  void disposeProvider(){
    centerName = '';
    centerAddress = '';
    centerGov = '';
    _answeredQuestions.clear();
  }
}