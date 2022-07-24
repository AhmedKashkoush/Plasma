import 'package:flutter/material.dart';
import 'package:plasma/Model/APIs/Notifications/notifications_api.dart';
import 'package:plasma/Model/Repositories/notifications_repository.dart';
import '../Model/Models/notification_model.dart';

class NotificationsViewModel extends ChangeNotifier
    implements NotificationsRepository {
  final NotificationsApi _api = NotificationsApi();
  final int limit = 20;
  int _page = 0;
  bool isLoading = false;
  bool hasError = false;
  bool isDone = false;
  static int newNotifications = 0;//AuthHelper.currentUser?.notifications?["new_notifications"] > 0? AuthHelper.currentUser?.notifications!["new_notifications"]: 0;

  static List<NotificationModel> notificationsList = [];
  // final List<String> _types = [
  //   'reservation',
  //   'reminder',
  //   'questionnaire',
  //   'medicalTestResult',
  //   'bonus',
  //   'auth',
  //   'user',
  // ];

  @override
  Future loadNotifications(int limit) async {
    isLoading = false;
    hasError = false;
    isDone = false;
    _page = 0;
    notificationsList.clear();
    // await Future.delayed(
    //   const Duration(seconds: 2),
    // );
    // notificationsList = List.generate(
    //   limit,
    //       (index) {
    //     int moddedIndex = index % _types.length;
    //     return NotificationModel(
    //       title: _types[moddedIndex],
    //       isOpened: false,
    //       time: DateTime.now(),
    //       body: 'Notification Body $index',
    //       type: NotificationType.values.byName(_types[moddedIndex]),
    //     );
    //   },
    // );
    // notificationsList.sort(
    //   (a, b) => b.time.compareTo(a.time),
    // );
    List _list = await _api.loadNotifications(this.limit);
    notificationsList = _list.map((notification) => NotificationModel.fromJson(notification)).toList();
    _page++;
    notifyListeners();
  }

  @override
  Future loadMoreNotifications(int limit,[int start = 0]) async {
    if (isDone) return;
    if (hasError) return;
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    try {
      // await Future.delayed(
      //   const Duration(seconds: 2),
      // );
      // List<NotificationModel> _newList = List.generate(
      //   limit,
      //   (index) {
      //     int moddedIndex = (notificationsList.length + index) % _types.length;
      //     return NotificationModel(
      //       title: _types[moddedIndex],
      //       isOpened: false,
      //       time: DateTime.now(),
      //       body: 'Notification Body ${notificationsList.length + index}',
      //       type: NotificationType.values.byName(_types[moddedIndex]),
      //     );
      //   },
      // );
      List _list = await _api.loadMoreNotifications(this.limit,this.limit * _page);
      if (_list.length == 0) isDone = true;
      List<NotificationModel> _newList = _list.map((notification) => NotificationModel.fromJson(notification)).toList();
      notificationsList.addAll(_newList);
    } catch (e) {
      hasError = true;
    }
    isLoading = false;
    _page++;
    //isDone = notificationsList.length == 80;
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
    loadMoreNotifications(limit,this.limit * _page);
  }

  @override
  Future incrementNotifications(NotificationModel model)async{
    await _api.incrementNotifications(model);
    await getNewNotifications();
    List<NotificationModel> reversedList = notificationsList.reversed.toList();
    reversedList.add(model);
    notificationsList.clear();
    notificationsList.addAll(reversedList.reversed.toList());
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

  @override
  Future setNotificationTapped(int index) async{
    await _api.setNotificationTapped(index);
  }
}
