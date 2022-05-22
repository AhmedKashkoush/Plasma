import 'package:flutter/material.dart';
import 'package:plasma/View/Mobile/predonation_screen.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_widget/time_picker_widget.dart';
import 'package:intl/intl.dart';

import '../Providers/question_screen_provider.dart';
import '../Widgets/place_select_card.dart';

class SelectDateTimeScreen extends StatefulWidget {
  final PageController pageController;

  const SelectDateTimeScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<SelectDateTimeScreen> createState() => _SelectDateTimeScreenState();
}

class _SelectDateTimeScreenState extends State<SelectDateTimeScreen> {
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final QuestionScreenProvider _provider =
        Provider.of<QuestionScreenProvider>(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => SingleChildScrollView(
            reverse: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Container(
                      clipBehavior: Clip.none,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Select Date And Time',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 32.0,
                              ),
                            ),
                            const SizedBox(height: 24,),
                            Text(
                              'All Centers Are Available 14 Hours Daily',
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(height: 24,),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                PlaceSelectCard(placeName: _provider.selectedCenter,),
                                Positioned(
                                  right: -22,
                                  top: -22,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.teal,shape: CircleBorder(),),
                                    child: Icon(Icons.edit,color: Colors.white70,),
                                    onPressed: (){
                                      _moveToPreviousPage();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            TextFormField(
                              controller: timeController,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('Time must not be empty');
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Donation Time',
                                prefixIcon: const Icon(
                                  Icons.watch_later_outlined,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                              onTap: () {
                                showCustomTimePicker(
                                    context: context,
                                    onFailValidation: (context) =>
                                        print('Unavailable selection'),
                                    initialTime: TimeOfDay(hour: 8, minute: 0),
                                    selectableTimePredicate: (time) =>
                                        time!.hour > 7 && time.hour < 21).then((value) {
                                  timeController.text = value!.format(context);
                                  print(value.format(context));
                                });
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('Date must not be empty');
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Donation Date',
                                prefixIcon: const Icon(
                                  Icons.calendar_today,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(DateTime.now().year + 5))
                                    .then((value) {
                                  print(DateFormat.yMMMd().format(value!));
                                  dateController.text = DateFormat.yMMMd().format(value);
                                });
                              },
                            ),
                            SizedBox(
                              height: 60.0,
                            ),
                            Container(
                              color: Theme.of(context).primaryColor,
                              height: 40.0,
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  'Reservation',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _moveToPreviousPage() {
    widget.pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
