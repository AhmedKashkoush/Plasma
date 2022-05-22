import 'package:flutter/material.dart';

//import 'package:plasma/View/sign_up.dart';

import '../../Utils/utils.dart';
import '../Widgets/translated_text_widget.dart';
import 'login.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPassword();
}

class _NewPassword extends State<NewPasswordScreen> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  bool obscureText = true;

  var formKey = GlobalKey<FormState>();

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
                      text: 'Type New Password',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 36.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: passController,
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return TranslatedTextWidget.translate('Empty');
                        }
                        return null;
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText:
                            TranslatedTextWidget.translate('New Password'),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
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
                          if (!formKey.currentState!.validate()) return;
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        // print(emailcontroller.text);
                        // print(passcontroller.text);

                        child: TranslatedTextWidget(
                          text: 'Reset Password',
                          style: TextStyle(
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
