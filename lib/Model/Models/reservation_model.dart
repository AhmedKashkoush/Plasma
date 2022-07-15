import 'package:fluttertoast/fluttertoast.dart';

class ReservationModel {
  final String place;
  final String date;
  final String time;
  final List<dynamic> questionsAnswers;

  ReservationModel({
    required this.place,
    required this.date,
    required this.time,
    required this.questionsAnswers,
  });

  static ReservationModel fromJson(Map<String, dynamic> json) {
    ReservationModel model = ReservationModel(
      place: json["place"],
      date: json["date"],
      time: json["time"],
      questionsAnswers: json["questions_answers"],
    );
    return model;
  }

  static Map<String, dynamic> toJson(ReservationModel model) =>
      <String, dynamic>{
        'place': model.place,
        'date': model.date,
        'time': model.time,
        'questions_answers': model.questionsAnswers,
      };
}
