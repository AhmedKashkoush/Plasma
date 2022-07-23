import 'dart:core';

import '../../View/Widgets/notification_widget.dart';

class NotificationModel {
  final String title;
  final String body;
  final DateTime time;
  bool isOpened;
  final NotificationType type;

  NotificationModel({
    required this.title,
    required this.body,
    required this.time,
    required this.isOpened,
    required this.type,
  });

  static NotificationModel fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"],
        body: json["body"],
        time: DateTime.parse(json["time"]),
        isOpened: json["is_opened"],
        type: NotificationType.values.byName(json["type"]),
      );

  static Map<String, dynamic> toJson(NotificationModel model) =>
      <String, dynamic>{
        'title': model.title,
        'body': model.body,
        'time': model.time.toString(),
        'is_opened': model.isOpened,
        'type': model.type.name,
      };
}
