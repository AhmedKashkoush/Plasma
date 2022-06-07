import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Model/Models/donor_type_model.dart';
import 'package:plasma/Model/Models/notifications_model.dart';
import 'package:plasma/Model/Models/reservation_model.dart';
import 'package:plasma/Model/Models/user_model.dart';
import 'package:plasma/Utils/auth.dart';

class AuthenticationViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  bool isLoading = false;
  bool _hasError = false;

  Future<UserCredential?> createNewUser(
      UserModel userModel, BuildContext context,
      [File? image]) async {
    UserCredential? _user;
    _hasError = false;
    isLoading = true;
    notifyListeners();
    try {
      String _imageUrl = '';
      _user = await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      if (image != null) {
        final Reference imagePath =
            await _storage.ref("/users/${userModel.nationalId}");
        imagePath.putFile(image);
        _imageUrl = await imagePath.getDownloadURL();
      }
      AuthHelper.currentUser = UserModel(
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        phone: userModel.phone,
        email: userModel.email,
        password: userModel.password,
        nationalId: userModel.nationalId,
        image: _imageUrl,
        bloodType: '',
        notifications: NotificationsModel.toJson(NotificationsModel(newNotifications: -1,notificationsList: [],)),
        reservation: ReservationModel.toJson(ReservationModel(place: '',date: null,time: null,)),
        donorTypeModel: DonorTypeModel.toJson(DonorTypeModel(type: null,delayTime: null)),
      );
      await _store
          .collection('users')
          .doc(_user.user?.uid)
          .set(UserModel.toJson(AuthHelper.currentUser!));
    } on Exception catch (e) {
      _hasError = true;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$e',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    }
    isLoading = false;
    notifyListeners();
    return _hasError?null:_user;
  }

  Future<void> verifyEmail(UserModel userModel,
      {required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(String, int?) codeSent,
      required void Function(String) codeAutoRetrievalTimeout}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: userModel.phone,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<UserCredential?> logIn(BuildContext context,String email,String password) async {
    isLoading = true;
    notifyListeners();
    try {
      UserCredential credentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = credentials.user;
      AuthHelper.currentUser = await getUserData(user);
      return credentials;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${e.runtimeType}',
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    }
    isLoading = false;
    notifyListeners();
    return null;
  }
  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future<UserModel?> getUserData(User? user) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _store.collection('users').doc(user?.uid).get();
    final Map<String, dynamic> data = snapshot.data()!;
    return UserModel.fromJson(data);
  }
}