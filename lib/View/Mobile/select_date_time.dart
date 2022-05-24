import 'package:flutter/material.dart';
import 'package:plasma/Utils/locales.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_widget/time_picker_widget.dart';
import 'package:intl/intl.dart' as intl;

import '../Providers/question_screen_provider.dart';
import '../Widgets/place_select_card.dart';
import '../Widgets/translated_text_widget.dart';

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
    bool isLTR = Directionality.of(context) == TextDirection.rtl;
    String? locale = LocaleHelper.currentLocale?.languageCode.substring(0, 2);
    final QuestionScreenProvider _provider =
        Provider.of<QuestionScreenProvider>(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SingleChildScrollView(
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
                            TranslatedTextWidget(
                              text: 'Select Date And Time',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 32.0,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TranslatedTextWidget(
                              text: 'All Centers Are Available 14 Hours Daily',
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                PlaceSelectCard(
                                  placeName: _provider.selectedCenter,
                                ),
                                Positioned(
                                  left: isLTR ? -22 : null,
                                  right: !isLTR ? -22 : null,
                                  top: -22,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.teal,
                                      shape: CircleBorder(),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {
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
                                  return TranslatedTextWidget.translate(
                                    'Time must not be empty',
                                  );
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: TranslatedTextWidget.translate(
                                  'Donation Time',
                                ),
                                prefixIcon: const Icon(
                                  Icons.watch_later_outlined,
                                ),
                                border: const OutlineInputBorder(),
                              ),
                              readOnly: true,
                              onTap: () {
                                showCustomTimePicker(
                                    context: context,
                                    onFailValidation: (context) =>
                                        print('Unavailable selection'),
                                    initialTime: TimeOfDay(hour: 8, minute: 0),
                                    selectableTimePredicate: (time) =>
                                        time!.hour > 7 && time.hour < 21).then(
                                    (value) {
                                  timeController.text = value!.format(context);
                                  print(value.format(context));
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return TranslatedTextWidget.translate(
                                    'Date must not be empty',
                                  );
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: TranslatedTextWidget.translate(
                                  'Donation Date',
                                ),
                                prefixIcon: const Icon(
                                  Icons.calendar_today,
                                ),
                                border: const OutlineInputBorder(),
                              ),
                              readOnly: true,
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate:
                                            DateTime(DateTime.now().year + 5))
                                    .then((value) {
                                  print(intl.DateFormat.yMMMd().format(value!));
                                  dateController.text =
                                      intl.DateFormat.yMMMd(locale)
                                          .format(value);
                                });
                              },
                            ),
                            const SizedBox(
                              height: 60.0,
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  Navigator.pop(context);
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 64,
                                  vertical: 14,
                                ),
                                child: TranslatedTextWidget(
                                  text: 'Reservation',
                                  style: const TextStyle(
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
