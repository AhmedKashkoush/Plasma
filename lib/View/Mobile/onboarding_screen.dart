import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:plasma/Utils/shared_preferences_api.dart';
import 'package:plasma/View/Mobile/before_login.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}):super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool firstOpen = true;

  _onIntroEnd(context) async {
    SharedPreferencesApi.setBool('on_boarding', true);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const BeforeLoginScreen()));
  }

  _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    var pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      imagePadding: EdgeInsets.symmetric(vertical: 30,),
      bodyAlignment: Alignment.center,
      imageAlignment: Alignment.center,
    );

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color foregroundColor = isDark? Colors.white:Colors.black;
    return IntroductionScreen(
      // globalBackgroundColor: Colors.amber[150],
      scrollPhysics: AlwaysScrollableScrollPhysics(),
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('care.png', 50),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: TranslatedTextWidget.translate("Plasma Donation"),
          body: TranslatedTextWidget.translate("Blood plasma is a cure, life and a new beginning"),
          image: _buildImage('avatar.png'),
          decoration: pageDecoration,
          useRowInLandscape: true,
        ),
        PageViewModel(
          title: TranslatedTextWidget.translate('Donation'),
          body:
    TranslatedTextWidget.translate("Help us collect the largest amount of blood plasma so that we can help all of our patients."),
          image: _buildImage('contact.png'),
          decoration: pageDecoration,
          useRowInLandscape: true,
        ),
        PageViewModel(
          title: TranslatedTextWidget.translate('Plasma is Important'),
          body:
    TranslatedTextWidget.translate('When you donate plasma, you will benefit a sick person by providing the appropriate treatment for him'),
          image: _buildImage('Properties.png'),
          decoration: pageDecoration,
          useRowInLandscape: true,
        ),
        PageViewModel(
          title: TranslatedTextWidget.translate('Save Your time'),
          body:
    TranslatedTextWidget.translate("""don't lose the time to now when you have to go to donation place

by using this app you will be able to donate and book an appointment in all places"""),
          image: _buildImage('appplasma.png'),
          decoration: pageDecoration,
          useRowInLandscape: true,
        ),
      ],
      onDone: () => _onIntroEnd(context), //push to home screan
      onSkip: () =>
          _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      // skipFlex: 0,
      nextStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(foregroundColor)),
      skipStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(foregroundColor)),
      doneStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(foregroundColor)),
      nextFlex: 0,
      skip: TranslatedTextWidget(text: 'Skip',
      ),
      next: const Icon(
        Icons.arrow_forward,
      ),
      done: TranslatedTextWidget(text: 'Done',
          style: const TextStyle(
              fontWeight: FontWeight.w600,)),
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.all(4),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        activeSize: Size(20.0, 10.0),
        activeColor: Theme.of(context).primaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color(0x60bbbbbb),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}