abstract class NotificationsRepository{
  Future loadNotifications(int limit);
  Future loadMoreNotifications(int limit);
  Future incrementNotifications();
  Future getNewNotifications();
  Future flushNotifications();
}