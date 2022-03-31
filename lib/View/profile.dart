import 'package:flutter/material.dart';
import 'package:plasma/View/login.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(
                  Icons.account_circle, size: 140, color: Colors.amber,

                ),

                Text('User Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                          fontSize:25
                  ),
                ),

                SizedBox(
    height:height*.1 ,
    ),
    CustomTextField(
    hint: 'Phone Number',
    icon: Icons.phone_android_outlined,

    ),
    SizedBox(
    height:height*.02 ,
    ),
    CustomTextField(
    hint: 'Mail',
    icon: Icons.email_outlined,
    ),
    SizedBox(
    height:height*.02 ,
    ),
    CustomTextField(
        hint: 'Blood Type',
    icon: Icons.bloodtype_outlined,),
    SizedBox(
    height:height*.1 ,
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 120),
    child: FlatButton(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)
    ),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>
          LoginScreen()
        )
      );
    },
    color: Colors.red,
    child:
    Row(mainAxisAlignment:MainAxisAlignment.spaceAround,
      children:<Widget>[
      Icon(
      Icons.logout),
        Text(
    'logout',style: TextStyle(
    color: Colors.black
    ),
    ) ,
      ]
    ),
    ),
    ),
         ]
        ),
          ),
      ),
    ),
    );
  }}

class CustomTextField extends StatelessWidget {
      final String hint;
     final IconData icon;
     CustomTextField( { required this.icon,required this.hint, });

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
            ),

              suffixIcon:IconButton(
                icon: Icon(Icons.mode_edit),
                onPressed: (){},

              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.amber
                )
            ),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.amber
                )
            ),


          ),

          readOnly: true,
        ),
      );

    }
  }

