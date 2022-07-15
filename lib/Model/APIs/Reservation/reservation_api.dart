import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plasma/Model/Models/reservation_model.dart';
import 'package:plasma/Model/Repositories/reservation_repository.dart';

class ReservationApi implements ReservationRepository<Map<String,dynamic>>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  @override
  Future cancelReservation() async{
    ReservationModel model = ReservationModel(place: "",time: "",date: "",questionsAnswers: []);
    Map<String,dynamic> _reservationData = ReservationModel.toJson(model);
    String uid = _auth.currentUser!.uid;
    Map<String,dynamic> _newData = {'reservation':_reservationData};
    await _store.collection('users').doc(uid).update(_newData);
  }

  @override
  Future<Map<String,dynamic>> getReservation() async{
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String,dynamic>> doc = await _store.collection('users').doc(uid).get();
    Map<String,dynamic> data = doc.data()!;
    Map<String,dynamic> reservationData = data['reservation'];
    return reservationData;
  }

  @override
  Future reserve(ReservationModel model) async{
    Map<String,dynamic> _reservationData = ReservationModel.toJson(model);
    String uid = _auth.currentUser!.uid;
    Map<String,dynamic> _newData = {'reservation':_reservationData};
    await _store.collection('users').doc(uid).update(_newData);
  }

}