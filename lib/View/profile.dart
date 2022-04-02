import 'package:flutter/material.dart';
import 'package:plasma/View/login.dart';

import 'Widgets/custom_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(children: [
              Icon(
                Icons.account_circle,
                size: 140,
                color: Colors.amber,
              ),
              Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                hint: 'Phone Number',
                icon: Icons.phone_android_outlined,
                isEditable: true,
                readOnly: true,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                hint: 'Mail',
                icon: Icons.email_outlined,
                isEditable: true,
                readOnly: true,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                hint: 'Blood Type',
                icon: Icons.bloodtype_outlined,
                readOnly: true,
              ),
              SizedBox(
                height: height * .1,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
