import 'package:flutter/material.dart';
import 'package:plasma/View/Providers/question_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../Model/Models/question_model.dart';
import '../Widgets/question_number_dot.dart';
import '../Widgets/translated_text_widget.dart';

class QuestionsScreen extends StatefulWidget {
  final PageController pageController;

  const QuestionsScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final PageController _questionPageController = PageController();
  // final ItemScrollController _controller = ItemScrollController();
  final PageController _controller = PageController(viewportFraction: 0.15);
  final List<QuestionModel> _questions = [
    QuestionModel(
      question: 'Are you over 18 years old?',
      answers: ['Yes', 'No'],
      correctAnswer: 'Yes',
    ),
    QuestionModel(
      question: 'Do you weigh more than 50 Kg?',
      answers: ['Yes', 'No'],
      correctAnswer: 'Yes',
    ),
    QuestionModel(
      question: 'Is your blood pressure level regular?',
      answers: ['Yes', 'No'],
      correctAnswer: 'Yes',
    ),
    QuestionModel(
      question: 'Do you suffer from Heart problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do you suffer from Liver problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do you suffer from Kidney problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do you suffer from Thyroid problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do you have Diabetes problems?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Have you received the CoronaVirus vaccine?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Have you had surgery in the last 6 months?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question:
          'Have you ever donated blood or one of its derivatives during the past three months?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question:
          'During the past 14 days, did you have any symptoms of the emerging corona virus?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question:
          'During the past 14 days, have you had contact with a patient infected with the emerging corona virus?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question:
          'Have you undergone any dental treatment (filling, extraction, root treatment, cleaning, whitening)?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
    QuestionModel(
      question: 'Do you live with someone who has hepatitis?',
      answers: ['Yes', 'No'],
      correctAnswer: 'No',
    ),
  ];

  int currentQuestion = 0;
  final double radius = 24;

  @override
  void dispose() {
    _questionPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QuestionScreenProvider _provider = Provider.of<QuestionScreenProvider>(context,listen: false);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: SizedBox(
              height: 50,
              child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: QuestionNumberDot(
                        numberIndex: index, currentQuestion: currentQuestion),
                  ),
                  itemCount: _questions.length,
                ),
              // child: ScrollablePositionedList.separated(
              //   physics: NeverScrollableScrollPhysics(),
              //   itemScrollController: _controller,
              //   scrollDirection: Axis.horizontal,
              //   itemBuilder: (context, index) => QuestionNumberDot(
              //       numberIndex: index, currentQuestion: currentQuestion),
              //   separatorBuilder: (BuildContext context, int index) =>
              //       const SizedBox(
              //     width: 10,
              //   ),
              //   itemCount: _questions.length,
              // ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: PageView.builder(
              controller: _questionPageController,
              itemCount: _questions.length,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TranslatedTextWidget(
                      text: _questions[index].question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _provider.setAnswer('yes');
                              _moveToNextQuestion();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radius)),
                          ),
                          child: TranslatedTextWidget(
                            text: _questions[index].answers[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(radius)),
                          ),
                          onPressed: () {
                            setState(() {
                              _provider.setAnswer('no');
                              _moveToNextQuestion();
                            });
                          },
                          child: TranslatedTextWidget(
                            text: _questions[index].answers[1],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _moveToNextPage() {
    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _moveToNextQuestion() {
    if (currentQuestion >= _questions.length - 1) {
      _moveToNextPage();
      return;
    }
    currentQuestion++;
    _questionPageController.animateToPage(
      currentQuestion,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    // _controller.scrollTo(
    //   index: currentQuestion,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    //   alignment: 0.5,
    // );
    _controller.animateToPage(currentQuestion, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
  }
}
