import 'package:flutter/material.dart';

class ReservationModel {
  final String? place;
  final DateTime? date;
  final TimeOfDay? time;

  ReservationModel(
      {required this.place, required this.date, required this.time});

  static ReservationModel fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        place: json["place"],
        date: json["date"],
        time: json["time"],
      );

  static Map<String, dynamic> toJson(ReservationModel model) =>
      <String, dynamic>{
        'place': model.place,
        'date': model.date,
        'time': model.time,
      };
}
