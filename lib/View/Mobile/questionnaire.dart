import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:emoji_feedback/emoji_feedback.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  bool obscureText = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var nameController;
    var numberController;
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
                      'assets/images/plasma_img.png',
                    ),
                    width: 100.0,
                    height: 100.0,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "In order to ensure that the Ministry of Health is providing the best service to donors, answer the following. ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 35.0,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "What is your rating for the service you received at the center in general?",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  EmojiFeedback(
                    onChange: (index) {
                      print(index);
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "What is your assessment of the performance of the service in terms of?",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 29.0,
                  ),
                  Text(
                    "Welcoming and good treatment",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  EmojiFeedback(
                    onChange: (index) {
                      print(index);
                    },
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Text(
                    "Availability of information and donor awareness",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  EmojiFeedback(
                    onChange: (index) {
                      print(index);
                    },
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Text(
                    "The level of medical safety and sterilization",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  EmojiFeedback(
                    onChange: (index) {
                      print(index);
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Enter your phone number and name, and one of the center's representatives will call you.",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return ('Required Field');
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: ('Your Name'),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return ('Required Field');
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: ('your phone'),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(32),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(280, 80),
                        textStyle: TextStyle(fontSize: 28),
                        primary: Colors.amber,
                        onPrimary: Colors.black,
                      ),
                      onPressed: () {},
                      child: Text("Send"),
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
