import 'package:flutter/material.dart';
import 'package:plasma/View/Mobile/login.dart';
import 'package:plasma/View/Mobile/sign_up.dart';

import '../../Utils/utils.dart';
import '../Widgets/translated_text_widget.dart';
import 'login.dart';

class BeforeLoginScreen extends StatelessWidget {
  const BeforeLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: double.infinity,
                height: 400.0,
                image: AssetImage(
                  brightness == Brightness.light
                      ? 'assets/images/plasma.png'
                      : 'assets/images/dark logo.png',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    height: 40.0,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: TranslatedTextWidget(
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    color: Theme.of(context).primaryColor,
                    height: 40.0,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: TranslatedTextWidget(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
