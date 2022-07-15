import 'package:plasma/Model/Models/reservation_model.dart';

abstract class ReservationRepository<T> {
  Future reserve(ReservationModel model);
  Future<T> getReservation();
  Future cancelReservation();
}