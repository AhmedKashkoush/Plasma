class QuestionModel {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  QuestionModel({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  static QuestionModel fromJson(Map<String, dynamic> json) => QuestionModel(
        question: json['question'],
        answers: json['answers'],
        correctAnswer: json['correctAnswer'],
      );

  static Map<String, dynamic> toJson(QuestionModel model) => <String, dynamic>{
        'question': model.question,
        'answers': model.answers,
        'correctAnswer': model.correctAnswer,
      };
}
