import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/Model/Repositories/notifications_repository.dart';

class NotificationsApi implements NotificationsRepository{
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String,dynamic>>> _init() async {
    final String uid = await _auth.currentUser!.uid;
    final DocumentSnapshot<Map<String,dynamic>> _data = await _store.collection('users').doc(uid).get();
    return _data;
  }
  @override
  Future getNewNotifications() async{
    final DocumentSnapshot<Map<String,dynamic>> _user = await _init();
    final Map<String,dynamic> _data = _user.data()!;
    final int _newNotifications = _data['notifications']['new_notifications'];
    return _newNotifications;
  }

  @override
  Future incrementNotifications() async{
    final String uid = await _auth.currentUser!.uid;
    final DocumentSnapshot<Map<String,dynamic>> _user = await _init();
    final Map<String,dynamic> _data = _user.data()!;
    final Map<String,dynamic>  _notificationsMap = _data['notifications'];
    _notificationsMap['new_notifications']++;
    _data['notifications'] = _notificationsMap;

    await _store.collection('users').doc(uid).update({"notifications": _notificationsMap});
  }

  @override
  Future loadMoreNotifications(int limit) {
    // TODO: implement loadMoreNotifications
    throw UnimplementedError();
  }

  @override
  Future loadNotifications(int limit) {
    // TODO: implement loadNotifications
    throw UnimplementedError();
  }

  @override
  Future flushNotifications() async{
    final String uid = await _auth.currentUser!.uid;
    final DocumentSnapshot<Map<String,dynamic>> _user = await _init();
    final Map<String,dynamic> _data = _user.data()!;
    final Map<String,dynamic>  _notificationsMap = _data['notifications'];
    _notificationsMap['new_notifications'] = 0;
    await _store.collection('users').doc(uid).update({"notifications": _notificationsMap});
  }

}