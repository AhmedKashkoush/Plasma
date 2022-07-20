import 'package:flutter/material.dart';

import '../../Utils/utils.dart';
import '../Widgets/mobile_custom_drawer.dart';
import '../Widgets/translated_text_widget.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        appBar: AppBar(
          title: TranslatedTextWidget(
            text: 'Benefits Of Plasma Donation',
          ),
          foregroundColor: Colors.white,
        ),
        drawer: const MobileCustomDrawer(
          screenIndex: 2,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TranslatedTextWidget(
                        text: 'Benefits For The Donor',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    //width: 500,
                    //height: 220,
                    //color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TranslatedTextWidget(
                                    text:
                                        '* Doing the analysis of acquired immunodeficiency (AIDS) and syphilis on a regular basis.',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TranslatedTextWidget(
                                    text:
                                        '* Blood protein analysis every 4 months',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TranslatedTextWidget(
                                    text: '* Hepatitis A,B, C virus analysis',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TranslatedTextWidget(
                                    text: '* Bone marrow activation',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TranslatedTextWidget(
                                    text: '* Strengthen the immune system',
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Image(
                                  image: AssetImage(
                                      'assets/images/analyzing.jpeg'),
                                ),
                                Image(
                                  image: AssetImage('assets/images/ph.jpeg'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TranslatedTextWidget(
                        text: 'Benefits For Patients',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    //width: 500,
                    //height: 220,
                    //color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            //width: 250,
                            padding: EdgeInsets.all(10),
                            child: TranslatedTextWidget(
                              text:
                                  '* Providing safe treatment and avoiding complications that occur as a result of the lack of necessary treatment such as joint obstruction for bleeding patients, avoiding cirrhosis and kidney failure for chronic viral hepatitis patients.',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            //width: 160,
                            child: const Image(
                              image: AssetImage(
                                'assets/images/heart.jpeg',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
