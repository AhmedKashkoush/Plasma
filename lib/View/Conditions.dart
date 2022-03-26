import 'package:flutter/material.dart';

class Conditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:
       
       
           Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                    color: Colors.amber,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 204, 194, 194),
                        radius: 30,
                        backgroundImage: AssetImage(
                          'images/avatar.png',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Conditions For Donating Blood Plasma',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Text(
                    'The Permissible Age Ranges From 18 To 60 .',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: Icon(
                    Icons.paste_sharp,
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                  color: Colors.amber,
                ),
                ListTile(
                  title: Text(
                    'Weight more than 50 kg.',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: Icon(
                    Icons.paste_sharp,
                  ),
                ),
               Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                  color: Colors.amber,
                ),
                ListTile(
                  title: Text(
                    'Blood pressure must be regular.',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: Icon(
                    Icons.paste_sharp,
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                  color: Colors.amber,
                ),
                ListTile(
                  title: Text(
                    'If the donor has diabetes, he should not take insulin.',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: Icon(
                    Icons.paste_sharp,
                  ),
                ),
               Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                  color: Colors.amber,
                ),
                ListTile(
                  title: Text(
                    'He does not suffer from any health problems in the heart, liver, kidneys or thyroid gland.',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: Icon(
                    Icons.paste_sharp,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 70.0,
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                    color: Colors.amber,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'The donor is examined and carefully examined to ensure that his health condition is suitable for plasma donation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
       ),
    );
  }
}

