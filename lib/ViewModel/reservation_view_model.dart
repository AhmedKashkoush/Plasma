import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plasma/Model/APIs/Reservation/reservation_api.dart';
import 'package:plasma/Model/Models/reservation_model.dart';
import 'package:plasma/Model/Repositories/reservation_repository.dart';
import 'package:plasma/View/Widgets/toast_widget.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class ReservationViewModel extends ChangeNotifier
    implements ReservationRepository<ReservationModel> {
  final ReservationApi _api = ReservationApi();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ReservationModel>? _data;
  late BuildContext _context;

  @override
  Future cancelReservation() async {
    bool success = true;
    try {
      _isLoading = true;
      notifyListeners();
      await _api.cancelReservation();
      if (success) ToastWidget.showToast(_context, msg: TranslatedTextWidget.translate('Reservation was cancelled'));
    } catch (e) {
      success = false;
    }
    _isLoading = false;
    _data = null;
    notifyListeners();
  }

  @override
  Future<ReservationModel> getReservation() async {
    if (_data != null) return _data!;
    late ReservationModel model;
    try {
      Map<String, dynamic> _data = await _api.getReservation();
      model = ReservationModel.fromJson(_data);
    } on Exception catch (e) {
      model = ReservationModel(time: '', questionsAnswers: [], date: '', place: '');
    }
    return model;
  }

  @override
  Future reserve(ReservationModel model) async {
    bool success = true;
    try {
      _isLoading = true;
      notifyListeners();
      await _api.reserve(model);
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
      success = false;
    }
    _isLoading = false;
    _data = null;
    notifyListeners();
    return success;
  }

  void setContext(BuildContext context){
    this._context = context;
  }
}
