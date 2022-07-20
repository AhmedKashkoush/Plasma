import 'package:flutter/material.dart';
import 'package:plasma/Model/APIs/Notifications/notifications_api.dart';
import 'package:plasma/Model/Repositories/notifications_repository.dart';
import 'package:plasma/View/Widgets/notification_widget.dart';
import '../Model/Models/notification_model.dart';

class NotificationsViewModel extends ChangeNotifier
    implements NotificationsRepository {
  final NotificationsApi _api = NotificationsApi();
  final int limit = 20;
  bool isLoading = false;
  bool hasError = false;
  bool isDone = false;
  int newNotifications = 0;//AuthHelper.currentUser?.notifications?["new_notifications"] > 0? AuthHelper.currentUser?.notifications!["new_notifications"]: 0;

  List<NotificationModel> notificationsList = [];
  final List<String> _types = [
    'reservation',
    'reminder',
    'questionnaire',
    'medicalTestResult',
    'bonus',
    'auth',
    'user',
  ];

  @override
  Future loadNotifications(int limit) async {
    isLoading = false;
    hasError = false;
    isDone = false;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    notificationsList = List.generate(
      limit,
          (index) {
        int moddedIndex = index % _types.length;
        return NotificationModel(
          title: _types[moddedIndex],
          isOpened: false,
          time: DateTime.now(),
          body: 'Notification Body $index',
          type: NotificationType.values.byName(_types[moddedIndex]),
        );
      },
    );
    notificationsList.sort(
      (a, b) => b.time.compareTo(a.time),
    );
    notifyListeners();
  }

  @override
  Future loadMoreNotifications(int limit) async {
    if (isDone) return;
    if (hasError) return;
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    try {
      await Future.delayed(
        const Duration(seconds: 2),
      );
      List<NotificationModel> _newList = List.generate(
        limit,
        (index) {
          int moddedIndex = (notificationsList.length + index) % _types.length;
          return NotificationModel(
            title: _types[moddedIndex],
            isOpened: false,
            time: DateTime.now(),
            body: 'Notification Body ${notificationsList.length + index}',
            type: NotificationType.values.byName(_types[moddedIndex]),
          );
        },
      );
      notificationsList.addAll(_newList);
      notificationsList.sort(
        (a, b) => b.time.compareTo(a.time),
      );
    } catch (e) {
      hasError = true;
    }
    isLoading = false;
    isDone = notificationsList.length == 80;
    notifyListeners();
  }

  Future<void> refresh() async {
    isLoading = false;
    hasError = false;
    isDone = false;
    await loadNotifications(limit);
  }

  Future<void> refreshOnError() async {
    hasError = false;
    loadMoreNotifications(limit);
  }

  @override
  Future incrementNotifications()async{
    await _api.incrementNotifications();
    await getNewNotifications();
    notifyListeners();
  }

  @override
  Future flushNotifications() async {
    newNotifications = 0;
    await _api.flushNotifications();
    notifyListeners();
  }

  @override
  Future getNewNotifications() async{
    newNotifications = await _api.getNewNotifications();
    notifyListeners();
  }
}
