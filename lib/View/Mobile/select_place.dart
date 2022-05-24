import 'package:flutter/material.dart';
import 'package:plasma/Model/APIs/Dummy/dummy_places.dart';
import 'package:plasma/View/Mobile/predonation_screen.dart';
import 'package:plasma/View/Widgets/place_select_card.dart';
import 'package:provider/provider.dart';

import '../Providers/question_screen_provider.dart';
import '../Widgets/translated_text_widget.dart';

class SelectPlaceScreen extends StatelessWidget {
  final PageController pageController;

  const SelectPlaceScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuestionScreenProvider _provider =
        Provider.of<QuestionScreenProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
          child: Column(
            children: [
              Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 204, 194, 194),
                      radius: 30,
                      backgroundImage: AssetImage(
                        'assets/images/place.png',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TranslatedTextWidget(
                      text: 'Plasma Collection Centers in Egypt',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TranslatedTextWidget(
                text: 'Select Center From Below',
                maxLines: 4,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    //horizontal: 20,
                    //vertical: 30,
                    ),
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => PlaceSelectCard(
                    placeName:
                        '${TranslatedTextWidget.translate(placesList[index]["name"]!)},${TranslatedTextWidget.translate(placesList[index]["address"]!)},${TranslatedTextWidget.translate(placesList[index]["gov"]!)}',
                    onTap: () {
                      _provider.setCenter(
                          '${TranslatedTextWidget.translate(placesList[index]["name"]!)},${TranslatedTextWidget.translate(placesList[index]["address"]!)},${TranslatedTextWidget.translate(placesList[index]["gov"]!)}');
                      _moveToNextPage();
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    thickness: 1,
                  ),
                  itemCount: placesList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _moveToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
