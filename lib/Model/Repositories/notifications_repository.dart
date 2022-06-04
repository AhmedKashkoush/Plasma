abstract class NotificationsRepository{
  Future loadNotifications(int limit);
  Future loadMoreNotifications(int limit);
}