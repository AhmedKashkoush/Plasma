import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionNumberDot extends StatelessWidget {
  final int numberIndex;
  final int currentQuestion;
  const QuestionNumberDot(
      {Key? key, required this.numberIndex, required this.currentQuestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: _checkValidity(context),
      child: Text(
        '${numberIndex + 1}',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _checkValidity(BuildContext context) {
    if (currentQuestion > numberIndex)
      return Theme.of(context).primaryColor;
    else if (currentQuestion == numberIndex)
      return Colors.blue.shade700;
    else
      return Colors.grey.shade600.withOpacity(0.4);
  }
}
