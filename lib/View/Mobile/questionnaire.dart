import 'package:flutter/material.dart';
import 'package:plasma/View/Widgets/rating_widget.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  bool obscureText = true;

  var formKey = GlobalKey<FormState>();
  String? radioValue = '';

  @override
  Widget build(BuildContext context) {
    var nameController;
    var numberController;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          //to make scroll
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Image(
                    image: AssetImage(
                      'assets/images/plasma_img.png',
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TranslatedTextWidget(
                  text:
                      "In the interest of the Ministry of Health to provide the best service to donors, answer the following:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Divider(
                  thickness: 1,
                ),
                TranslatedTextWidget(
                  text:
                      "What is your rating for the service you received at the center in general?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                RatingWidget(
                  onRatingUpdate: (rate) {},
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Divider(
                  thickness: 1,
                  indent: 14,
                  endIndent: 84,
                ),
                TranslatedTextWidget(
                  text:
                      "What is your assessment of the performance of the service in terms of:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 28.0,
                ),
                TranslatedTextWidget(
                  text: "1- Welcoming and good treatment?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                RatingWidget(
                  onRatingUpdate: (rate) {},
                ),
                const SizedBox(
                  height: 28.0,
                ),
                const Divider(
                  thickness: 1,
                  indent: 14,
                  endIndent: 84,
                ),
                TranslatedTextWidget(
                  text: "2- Availability of information and donor awareness?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                RatingWidget(
                  onRatingUpdate: (rate) {},
                ),
                const SizedBox(
                  height: 28.0,
                ),
                const Divider(
                  thickness: 1,
                  indent: 14,
                  endIndent: 84,
                ),
                TranslatedTextWidget(
                  text: "3- The level of medical safety and sterilization?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                RatingWidget(
                  onRatingUpdate: (rate) {},
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Divider(
                  thickness: 1,
                  indent: 14,
                  endIndent: 84,
                ),
                TranslatedTextWidget(
                  text: "Would you like to be a regular donor?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                RadioListTile(
                    title: TranslatedTextWidget(text: 'Yes',),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: 'yes',
                    groupValue: radioValue,
                    onChanged: (String? value) {
                      setState(() {
                        radioValue = value;
                      });
                    }),
                RadioListTile(
                    title: TranslatedTextWidget(text: 'No',),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: 'no',
                    groupValue: radioValue,
                    onChanged: (String? value) {
                      setState(() {
                        radioValue = value;
                      });
                    }),
                const Divider(
                  thickness: 1,
                ),
                // TranslatedTextWidget(
                //   text:
                //       "Enter your name and phone number, and one of the center's representatives will call you.",
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                // const SizedBox(
                //   height: 15.0,
                // ),
                // // TextFormField(
                // //   controller: nameController,
                // //   keyboardType: TextInputType.name,
                // //   onFieldSubmitted: (value) {
                // //     print(value);
                // //   },
                // //   onChanged: (value) {
                // //     print(value);
                // //   },
                // //   validator: (String? value) {
                // //     if (value!.isEmpty) {
                // //       return TranslatedTextWidget.translate('Required Field');
                // //     }
                // //
                // //     return null;
                // //   },
                // //   decoration: InputDecoration(
                // //     labelText: TranslatedTextWidget.translate('Your Name'),
                // //     border: const OutlineInputBorder(),
                // //   ),
                // // ),
                // // const SizedBox(
                // //   height: 15.0,
                // // ),
                // // TextFormField(
                // //   controller: numberController,
                // //   keyboardType: TextInputType.number,
                // //   onFieldSubmitted: (value) {
                // //     print(value);
                // //   },
                // //   onChanged: (value) {
                // //     print(value);
                // //   },
                // //   validator: (String? value) {
                // //     if (value!.isEmpty) {
                // //       return TranslatedTextWidget.translate('Required Field');
                // //     }
                // //
                // //     return null;
                // //   },
                // //   decoration: InputDecoration(
                // //     labelText: TranslatedTextWidget.translate('Your Phone'),
                // //     border: const OutlineInputBorder(),
                // //   ),
                // // ),
                // // const SizedBox(
                // //   height: 30.0,
                // // ),
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.all(24),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // minimumSize: Size(280, 80),
                      // textStyle: TextStyle(fontSize: 28),
                      // primary: Colors.amber,
                      // onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 34),
                    ),
                    onPressed: () {
                      formKey.currentState!.validate();
                    },
                    child: TranslatedTextWidget(text: "Send"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
