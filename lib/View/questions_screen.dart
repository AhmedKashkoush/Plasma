import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Model/Models/question_model.dart';
import 'package:plasma/View/Widgets/blood_loading.dart';
import 'package:plasma/View/Widgets/custom_text_field.dart';
import 'package:plasma/View/Widgets/question_number_dot.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final ItemScrollController _controller = ItemScrollController();
  final PageController _pageController = PageController();
  final PageController _questionPageController = PageController();
  final TextEditingController textController = TextEditingController();
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
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _confirmDialog(context) ?? false;
      },
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: SizedBox(
                    height: 50,
                    child: ScrollablePositionedList.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemScrollController: _controller,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => QuestionNumberDot(
                          numberIndex: index, currentQuestion: currentQuestion),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 10,
                      ),
                      itemCount: _questions.length,
                    ),
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
                          child: Text(
                            _questions[index].question,
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
                                    _moveToNextQuestion();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue.shade700),
                                child: Text(
                                  _questions[index].answers[0],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _moveToNextQuestion();
                                  });
                                },
                                child: Text(
                                  _questions[index].answers[1],
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
          ),
          Scaffold(
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  SingleChildScrollView(
                reverse: true,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          SizedBox(
                              height: 150,
                              child: Image.asset(
                                'images/logo.png',
                              )),
                          const Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                          Center(
                            child: Text(
                              'If You Were Asked Similar Questions Please Inform Us With It',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          CustomTextField(
                            controller: textController,
                            hint: 'Write Question',
                            onChanged: (s) {
                              setState(() {});
                            },
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.shade800,
                              onPrimary: Colors.white,
                              elevation: 0,
                            ),
                            onPressed: textController.text.isNotEmpty
                                ? () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => WillPopScope(
                                        onWillPop: () async {
                                          return false;
                                        },
                                        child: AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          content: Container(
                                            padding: const EdgeInsets.all(50),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: const [
                                                BloodLoadingIndicator(),
                                                const SizedBox(
                                                  width: 32,
                                                ),
                                                Text(
                                                  'Submitting...',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    await Future.delayed(
                                        const Duration(seconds: 5), () {
                                      Navigator.pop(context);
                                    });
                                  }
                                : null,
                            child: const Text('Submit Question'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: const Text('Skip This Step'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _moveToNextQuestion() {
    if (currentQuestion >= _questions.length - 1) {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }
    currentQuestion++;
    _questionPageController.animateToPage(
      currentQuestion,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _controller.scrollTo(
      index: currentQuestion,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.5,
    );
  }

  Future<bool?> _confirmDialog(BuildContext context) async => await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Go Back?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
}
