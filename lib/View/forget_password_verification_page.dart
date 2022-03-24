import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';

import 'package:hexcolor/hexcolor.dart';

import 'Widgets/new_password.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordVerificationPageState createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;

  var formKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'images/plasma_img.png',
                    ),
                    width: 100.0,
                    height: 100.0,
                  ),
                  const Text(
                    'Verification',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 36.0),
                  ),
                  SizedBox(height: 40.0),
                  Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        OTPTextField(
                          length: 4,
                          width: 300,
                          fieldWidth: 50,
                          style: TextStyle(fontSize: 30),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          //fieldStyle: FieldStyle.underline,
                          onCompleted: (pin) {
                            setState(() {
                              _pinSuccess = true;
                            });
                          },
                        ),
                        SizedBox(height: 50.0),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "If you didn't receive a code! ",
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                              TextSpan(
                                text: 'Resend',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ThemeHelper().alartDialog(
                                            "Successful",
                                            "Verification code resend successful.",
                                            context);
                                      },
                                    );
                                  },
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          decoration: _pinSuccess
                              ? ThemeHelper().buttonBoxDecoration(context)
                              : ThemeHelper().buttonBoxDecoration(
                                  context, "#AAAAAA", "#757575"),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Verify".toUpperCase(),
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
                                                NewPassword()),
                                        (Route<dynamic> route) => false);
                                  }
                                : null,
                          ),
                        ),
                      ]))
                ])))));
  }
}

class ThemeHelper {
  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).accentColor;
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
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
