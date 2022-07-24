import 'package:plasma/Model/Models/notification_model.dart';

abstract class NotificationsRepository{
  Future loadNotifications(int limit);
  Future loadMoreNotifications(int limit,[int start = 0]);
  Future incrementNotifications(NotificationModel model);
  Future getNewNotifications();
  Future flushNotifications();
  Future setNotificationTapped(int index);
}