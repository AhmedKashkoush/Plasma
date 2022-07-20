import 'package:flutter/material.dart';
import 'package:plasma/Model/Models/reservation_model.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';
import 'package:plasma/ViewModel/reservation_view_model.dart';
import 'package:provider/provider.dart';

class ReservationBannerWidget extends StatelessWidget {
  final ReservationModel model;

  const ReservationBannerWidget({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String? locale = LocaleHelper.currentLocale?.languageCode.substring(0, 2);
    String _date = model.date;
    final ReservationViewModel _vm = Provider.of<ReservationViewModel>(context);
    return ListTile(
      title: TranslatedTextWidget(
        text:model.place,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '$_date\n${model.time}',
        style: const TextStyle(color: Colors.white70),
      ),
      isThreeLine: true,
      tileColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),),
      leading: const Icon(Icons.alarm, color: Colors.white),
      trailing: IconButton(
        icon: _vm.isLoading? const CircularProgressIndicator(color: Colors.white,):const Icon(Icons.close, color: Colors.white),
        onPressed: () async {
          bool? confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: TranslatedTextWidget(text:'Cancel Reservation?'),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () async {
                    Navigator.pop(context, true);
                  },
                  child: TranslatedTextWidget(
                    text: 'Yes',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context, false);
                  },
                  child: TranslatedTextWidget(
                    text: 'No',
                  ),
                ),
              ],
            ),
          );
          if (confirm!) {
            await _vm.cancelReservation();
          }
        },
      ),
    );
  }
}
