import 'package:flutter/material.dart';

import '../../Utils/utils.dart';
import '../Widgets/translated_text_widget.dart';
import 'forget_password_verification_page.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPasswordScreen> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  bool obscureText = true;

  var formKey = GlobalKey<FormState>();

  var auth;

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
              child: Form(
                key: formKey,
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
                    const SizedBox(
                      height: 30.0,
                    ),
                    TranslatedTextWidget(
                      text: 'Reset your Password',
                      style:
                          const TextStyle(fontWeight: FontWeight.w500, fontSize: 36.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return TranslatedTextWidget.translate('Empty');
                        }
                        if (!value.contains('@')) {
                          return TranslatedTextWidget.translate('It is not a valid email address');
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: TranslatedTextWidget.translate('Email Address'),
                        prefixIcon: const Icon(
                          Icons.mail,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      color: Colors.amber,
                      height: 40.0,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ForgotPasswordVerificationScreen(),
                              ),
                            );
                          }
                        },
                        child: TranslatedTextWidget(
                          text: 'Send',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
