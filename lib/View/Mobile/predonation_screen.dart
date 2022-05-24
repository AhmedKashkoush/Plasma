import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Model/Models/question_model.dart';
import 'package:plasma/View/Mobile/questions_screen.dart';
import 'package:plasma/View/Mobile/similar_questions_screen.dart';
import 'package:plasma/View/Providers/question_screen_provider.dart';
import 'package:plasma/View/Widgets/blood_loading.dart';
import 'package:plasma/View/Widgets/custom_text_field.dart';
import 'package:plasma/View/Widgets/question_number_dot.dart';
import 'package:plasma/View/Mobile/select_date_time.dart';
import 'package:plasma/View/Mobile/select_place.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../Widgets/translated_text_widget.dart';

class PreDonationScreen extends StatefulWidget {
  const PreDonationScreen({Key? key}) : super(key: key);

  @override
  _PreDonationScreenState createState() => _PreDonationScreenState();
}

class _PreDonationScreenState extends State<PreDonationScreen> {
  final ItemScrollController _controller = ItemScrollController();
  final PageController _pageController = PageController();
  final PageController _questionPageController = PageController();
  final List<QuestionModel> _questions = [
    QuestionModel(
      question: 'Are You Over 18 Years Old?',
      answers: ['Yes', 'No'],
      correctAnswer: 'Yes',
    ),
    QuestionModel(
      question: 'Do You Weigh More Than 50 Kg?',
      answers: ['Yes', 'No'],
      correctAnswer: 'Yes',
    ),
    QuestionModel(
      question: 'Is Your Blood Pressure Level Regular?',
      answers: ['Yes', 'No'],
      correctAnswer: 'Yes',
    ),
    QuestionModel(
      question: 'Do You Suffer From Heart Problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do You Suffer From Liver Problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do You Suffer From Kidney Problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do You Suffer From Thyroid Problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do You Have Diabetes Problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Have You Received The CoronaVirus Vaccine?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Have You Had Surgery in The Last 6 Months?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
  ];

  int currentQuestion = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _questionPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final QuestionScreenProvider _provider = Provider.of<QuestionScreenProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return await _confirmDialog(context) ?? false;
      },
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          QuestionsScreen(pageController: _pageController),
          SimilarQuestionsScreen(pageController: _pageController),
          SelectPlaceScreen(pageController: _pageController),
          SelectDateTimeScreen(pageController: _pageController),
        ],
      ),
    );
  }

  void _moveToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<bool?> _confirmDialog(BuildContext context) async =>
      await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: TranslatedTextWidget(
                text: 'Go Back?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: TranslatedTextWidget(
                    text: 'Ok',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: TranslatedTextWidget(
                    text: 'Cancel',
                  ),
                ),
              ],
            ),
      );
}
