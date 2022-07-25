import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/Model/Models/user_model.dart';
import 'package:plasma/Utils/notification_helper.dart';

class AuthHelper{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _store = FirebaseFirestore.instance;
  static UserModel? currentUser;
  static Future<void> getUserData() async {
    try {
      if (_auth.currentUser == null) return;
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _store.collection('users').doc(_auth.currentUser?.uid).get();
      final Map<String, dynamic> data = snapshot.data()!;
      currentUser = UserModel.fromJson(data);
      ConnectivityResult _connectivity = await Connectivity().checkConnectivity();
      if (_connectivity != ConnectivityResult.none) await NotificationHelper.subscribeToTopic(currentUser!.nationalId);
    } catch (e) {
      currentUser = null;
    }
  }

  static Future<bool> logOut() async {
    try {
      await _auth.signOut();
      await NotificationHelper.unsubscribeFromTopic(currentUser!.nationalId);
      currentUser = null;
      return true;
    } catch (e) {
    }
    return false;
  }
}