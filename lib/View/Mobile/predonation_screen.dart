import 'package:flutter/material.dart';
import 'package:plasma/View/Mobile/questions_screen.dart';
import 'package:plasma/View/Mobile/medication_screen.dart';
import 'package:plasma/View/Mobile/select_date_time.dart';
import 'package:plasma/View/Mobile/select_place.dart';

import '../Widgets/translated_text_widget.dart';

class PreDonationScreen extends StatefulWidget {
  const PreDonationScreen({Key? key}) : super(key: key);

  @override
  _PreDonationScreenState createState() => _PreDonationScreenState();
}

class _PreDonationScreenState extends State<PreDonationScreen> {
  final PageController _pageController = PageController();
  final PageController _questionPageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    _questionPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _confirmDialog(context) ?? false;
      },
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          QuestionsScreen(pageController: _pageController),
          MedicationScreen(pageController: _pageController),
          SelectPlaceScreen(pageController: _pageController),
          SelectDateTimeScreen(pageController: _pageController),
        ],
      ),
    );
  }

  Future<bool?> _confirmDialog(BuildContext context) async =>
      await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: TranslatedTextWidget(
                text: 'Go Back?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: TranslatedTextWidget(
                    text: 'Ok',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: TranslatedTextWidget(
                    text: 'Cancel',
                  ),
                ),
              ],
            ),
      );
}
