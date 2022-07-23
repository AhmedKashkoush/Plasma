import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/Model/Models/notification_model.dart';
import 'package:plasma/Model/Repositories/notifications_repository.dart';

class NotificationsApi implements NotificationsRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> _init() async {
    final String uid = await _auth.currentUser!.uid;
    final DocumentSnapshot<Map<String, dynamic>> _data =
        await _store.collection('users').doc(uid).get();
    return _data;
  }

  @override
  Future getNewNotifications() async {
    final DocumentSnapshot<Map<String, dynamic>> _user = await _init();
    final Map<String, dynamic> _data = _user.data()!;
    final int _newNotifications = _data['notifications']['new_notifications'];
    return _newNotifications;
  }

  @override
  Future incrementNotifications(NotificationModel model) async {
    final String uid = await _auth.currentUser!.uid;
    final DocumentSnapshot<Map<String, dynamic>> _user = await _init();
    final Map<String, dynamic> _data = _user.data()!;
    final Map<String, dynamic> _notificationsMap = _data['notifications'];
    final Map<String, dynamic> _message = NotificationModel.toJson(model);
    _notificationsMap['new_notifications']++;
    List _list = _notificationsMap['notifications_list'];
    _list.add(_message);
    _notificationsMap['notifications_list'] = _list;
    _data['notifications'] = _notificationsMap;
    await _store
        .collection('users')
        .doc(uid)
        .update({"notifications": _notificationsMap});
  }

  @override
  Future loadMoreNotifications(int limit, [int start = 0]) async {
    final DocumentSnapshot<Map<String, dynamic>> _user = await _init();
    final Map<String, dynamic> _data = _user.data()!;
    final List _notificationsList =
        _data['notifications']['notifications_list'];
    List filteredList = _notificationsList;
    filteredList.sort((a, b) => b['time'].compareTo(a['time']));
    int length = _notificationsList.length > start+limit? start+limit: _notificationsList.length;
    filteredList = filteredList.sublist(start,length);
      // ..where((element) =>
      //     _notificationsList.indexOf(element) >= start &&
      //     _notificationsList.indexOf(element) < start + limit).toList();
    return filteredList;
  }

  @override
  Future loadNotifications(int limit) async {
    final DocumentSnapshot<Map<String, dynamic>> _user = await _init();
    final Map<String, dynamic> _data = _user.data()!;
    final List _notificationsList =
        _data['notifications']['notifications_list'];
    List filteredList = _notificationsList;
    filteredList.sort((a, b) => b['time'].compareTo(a['time']));
    filteredList = filteredList.sublist(0,limit);
    return filteredList;
  }

  @override
  Future flushNotifications() async {
    final String uid = await _auth.currentUser!.uid;
    final DocumentSnapshot<Map<String, dynamic>> _user = await _init();
    final Map<String, dynamic> _data = _user.data()!;
    final Map<String, dynamic> _notificationsMap = _data['notifications'];
    _notificationsMap['new_notifications'] = 0;
    await _store
        .collection('users')
        .doc(uid)
        .update({"notifications": _notificationsMap});
  }
}
