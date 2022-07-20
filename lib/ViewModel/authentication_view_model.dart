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
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class AuthenticationViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  bool _isLoading = false;
  bool _hasError = false;

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  Future<UserCredential?> createNewUser(
      UserModel userModel, BuildContext context,
      [File? image]) async {
    UserCredential? _user;
    _hasError = false;
    _isLoading = true;
    notifyListeners();
    try {
      String _imageUrl = '';
      _user = await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      if (image != null) {
        final Reference imagePath = await _storage
            .ref()
            .child("users")
            .child("${userModel.nationalId}")
            .child("/${userModel.nationalId}.png");
        await imagePath.putFile(image);
        _imageUrl = await imagePath.getDownloadURL();
      }
      UserModel user = UserModel(
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        gender: userModel.gender,
        phone: userModel.phone,
        email: userModel.email,
        password: userModel.password,
        nationalId: userModel.nationalId,
        image: _imageUrl,
        bloodType: '',
        notifications: NotificationsModel.toJson(NotificationsModel(
          newNotifications: 0,
          notificationsList: [],
        )),
        reservation: ReservationModel.toJson(ReservationModel(
          place: '',
          date: '',
          time: '',
          questionsAnswers: [],
        )),
        donorTypeModel:
            DonorTypeModel.toJson(DonorTypeModel(type: null, delayTime: null)),
      );
      await _store
          .collection('users')
          .doc(_user.user?.uid)
          .set(UserModel.toJson(user));
      await _auth.signOut();
      //await NotificationHelper.subscribeToTopic(user.nationalId);
    } on FirebaseAuthException catch (e) {
      _hasError = true;
      String message = 'Something went wrong';
      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already in use';
          break;
        case 'invalid-email':
          message = 'It is not a valid email address';
          break;
        case 'weak-password':
          message = 'This password is weak';
          break;
        default:
          message = 'Something went wrong';
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TranslatedTextWidget(
          text: message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ));
    }
    _isLoading = false;
    notifyListeners();
    return _hasError ? null : _user;
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

  Future<UserCredential?> logIn(
      BuildContext context, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      UserCredential credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credentials.user;
      AuthHelper.currentUser = await getUserData(user);
      _isLoading = false;
      notifyListeners();
      return credentials;
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong';
      switch (e.code) {
        case 'invalid-email':
          message = 'It is not a valid email address';
          break;
        case 'user-not-found':
          message = 'This user was not found';
          break;
        case 'wrong-password':
          message = 'The password entered is wrong';
          break;
        default:
          message = 'Something went wrong';
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TranslatedTextWidget(
          text: message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ));
    }
    _isLoading = false;
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

  Future<bool> updateUserImage(File image) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    try {
      UserModel userModel = AuthHelper.currentUser!;
      String _imageUrl;
      final Reference imagePath = await _storage
          .ref()
          .child("users")
          .child("${userModel.nationalId}")
          .child("/${userModel.nationalId}.png");
      await imagePath.putFile(image);
      _imageUrl = await imagePath.getDownloadURL();
      Map<String, dynamic> _newData = {'image': _imageUrl};
      await _store
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(_newData);
      AuthHelper.currentUser = await getUserData(_auth.currentUser);
    } catch (e) {
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
    return _hasError;
  }

  Future<bool> deleteUserImage() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    try {
      UserModel userModel = AuthHelper.currentUser!;
      await _storage
          .ref()
          .child("users")
          .child("${userModel.nationalId}")
          .child("/${userModel.nationalId}.png")
          .delete();
      Map<String, dynamic> _newData = {'image': ''};
      await _store
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(_newData);
      AuthHelper.currentUser = await getUserData(_auth.currentUser);
    } catch (e) {
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
    return _hasError;
  }
}
