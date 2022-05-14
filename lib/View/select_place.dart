import 'package:flutter/material.dart';
import 'package:plasma/Model/APIs/Dummy/dummy_places.dart';
import 'package:plasma/View/questions_screen.dart';

class SelectPlaceScreen extends StatelessWidget {
  final PageController pageController;

  const SelectPlaceScreen({Key? key, required this.pageController})
      : super(key: key);

  static final GlobalKey<QuestionsScreenState> _questionScreenKey =
      GlobalKey<QuestionsScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
        child: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) => MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    elevation: 10.0,
                    minWidth: 200.0,
                    height: 35,
                    color: Colors.amberAccent,
                    onPressed: () {
                      _questionScreenKey.currentState
                        ?..selectedCenter =
                            '${placesList[index]["name"]},${placesList[index]["address"]},${placesList[index]["gov"]}'
                        ..setState(() {});
                      _moveToNextPage();
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 204, 194, 194),
                          radius: 10,
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
                      const Divider(),
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
