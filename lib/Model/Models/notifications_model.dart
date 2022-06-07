import 'package:plasma/Model/Models/notification_model.dart';

class NotificationsModel {
  final int? newNotifications;
  final List<NotificationModel>? notificationsList;

  NotificationsModel(
      {required this.newNotifications, required this.notificationsList});

  static NotificationsModel fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        newNotifications: json["new_notifications"],
        notificationsList: json["notifications_list"]
      );

  static Map<String, dynamic> toJson(NotificationsModel model) =>
      <String, dynamic>{
        'new_notifications': model.newNotifications ?? '',
        'notifications_list': model.notificationsList!
            .map(
              (notification) => NotificationModel.toJson(notification),
            )
            .toList(),
      };
}
