import 'dart:html';

import 'package:flutter/material.dart';

import 'forget_password_verification_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  bool obscureText = true;

  var formKey = GlobalKey<FormState>();

  var auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'images/plasma_img.png',
                    ),
                    width: 100.0,
                    height: 100.0,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    'Reset your Password',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 36.0),
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
                        return 'empty';
                      }
                      if (!value.contains('@')) {
                        return 'it is not a valid email address ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(
                        Icons.mail,
                      ),
                      border: OutlineInputBorder(),
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
                                    ForgotPasswordVerificationPage()),
                          );
                        }
                      },
                      child: const Text(
                        'SEND',
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
    );
  }
}
