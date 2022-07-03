import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:otp_text_field/otp_field_style.dart';

import '../../Utils/utils.dart';
import '../Widgets/translated_text_widget.dart';
import 'new_password.dart';

class ForgotPasswordVerificationScreen extends StatefulWidget {
  const ForgotPasswordVerificationScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordVerificationScreenState createState() =>
      _ForgotPasswordVerificationScreenState();
}

class _ForgotPasswordVerificationScreenState
    extends State<ForgotPasswordVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;

  int otpLength = 4;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              //to make scroll
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/plasma_img.png',
                    ),
                    width: 100.0,
                    height: 100.0,
                  ),
                  TranslatedTextWidget(
                    text: 'Verification',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 36.0),
                  ),
                  const SizedBox(height: 40.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        OTPTextField(
                          length: otpLength,
                          width: 300,
                          fieldWidth: 50,
                          style: const TextStyle(fontSize: 30),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          otpFieldStyle: OtpFieldStyle(
                            enabledBorderColor:
                                Theme.of(context).iconTheme.color!,
                            focusBorderColor: Theme.of(context).primaryColor,
                          ),
                          //fieldStyle: FieldStyle.underline,
                          onCompleted: (pin) {
                            setState(() {
                              _pinSuccess = true;
                            });
                          },
                          onChanged: (string) {
                            setState(() {
                              _pinSuccess = string.length == otpLength;
                            });
                          },
                        ),
                        const SizedBox(height: 50.0),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: TranslatedTextWidget.translate(
                                    "If you didn't receive a code!"),
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: TranslatedTextWidget.translate('Resend'),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ThemeHelper().alartDialog(
                                          TranslatedTextWidget.translate(
                                              "Success"),
                                          TranslatedTextWidget.translate(
                                              "Verification code resent successfully"),
                                          context,
                                        );
                                      },
                                    );
                                  },
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Container(
                          // decoration: _pinSuccess
                          //     ? ThemeHelper().buttonBoxDecoration(context)
                          //     : ThemeHelper().buttonBoxDecoration(
                          //         context, "#AAAAAA", "#757575"),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: TranslatedTextWidget(
                                text: "Verify".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: _pinSuccess
                                ? () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NewPasswordScreen(),
                                        ),
                                        (Route<dynamic> route) => false);
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeHelper {
  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).colorScheme.secondary;
    if (color1.isEmpty == false) {
      c1 = HexColor(color1);
    }
    if (color2.isEmpty == false) {
      c2 = HexColor(color2);
    }

    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      minimumSize: Size(50, 50),
      primary: Colors.blue.shade800,
      shadowColor: Colors.transparent,
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: TranslatedTextWidget(
            text: "Ok",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black12),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
