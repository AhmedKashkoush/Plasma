import 'package:flutter/material.dart';
import 'package:plasma/Model/APIs/Dummy/dummy_places.dart';
import 'package:plasma/View/questions_screen.dart';
import 'package:provider/provider.dart';

import 'Providers/question_screen_provider.dart';

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
                  color: Colors.amber,
                ),
                child: Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 204, 194, 194),
                      radius: 30,
                      backgroundImage: AssetImage(
                        'images/place.png',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Plasma Collection Centers in Egypt',
                      style: TextStyle(
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
              Text(
                'Select Center From Below',
                maxLines: 4,
                textAlign: TextAlign.center,
                style: TextStyle(
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
                  itemBuilder: (context, index) => MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    elevation: 2.0,
                    minWidth: 200.0,
                    height: 35,
                    color: Colors.amber,
                    onPressed: () {
                      _provider.setCenter(
                          '${placesList[index]["name"]},${placesList[index]["address"]},${placesList[index]["gov"]}');
                      _moveToNextPage();
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 204, 194, 194),
                          radius: 20,
                          backgroundImage: AssetImage(
                            'images/place.png',
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '${placesList[index]["name"]},${placesList[index]["address"]},${placesList[index]["gov"]}',
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(thickness: 1,),
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
