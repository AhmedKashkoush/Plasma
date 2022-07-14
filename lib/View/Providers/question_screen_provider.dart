import 'package:flutter/material.dart';

class QuestionScreenProvider extends ChangeNotifier{
  String selectedCenter = '';
  List<String> _answeredQuestions = [];

  List<String> get answeredQuestions => _answeredQuestions;

  void setCenter(String name){
    selectedCenter = name;
    notifyListeners();
  }

  void setAnswer(String answer){
    _answeredQuestions.add(answer);
  }

  void disposeProvider(){
    selectedCenter = '';
    _answeredQuestions.clear();
  }
}