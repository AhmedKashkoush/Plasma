import 'package:flutter/material.dart';
import 'package:plasma/View/Mobile/predonation_screen.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';
import 'package:provider/provider.dart';
import '../Providers/question_screen_provider.dart';

class BeforeQuestions extends StatelessWidget {
  const BeforeQuestions({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(
                  'assets/images/iconattention.png',
                ),
                width: 200,
                color: const Color(0x88FF0202),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: TranslatedTextWidget(
                    text: """Dear donor...

 Before donating, you will be asked several personal and sensitive questions, 
and we hope not to embarrass you.
 Your honest answers will ensure that the blood transfusion is as safe as possible.
 All information you provide will be treated confidentially.""",
                    maxLines: 20,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.blueGrey[400],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                  color: Theme.of(context).primaryColor,
                  elevation: 15,
                  onPressed: () => {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (BuildContext context) =>
                              QuestionScreenProvider(),
                          child: const PreDonationScreen(),
                        ),
                      ),
                    )
                  },
                  child: TranslatedTextWidget(
                    text: 'Go To Donation Questions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
