import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/Mobile/predonation_screen.dart';
import 'package:provider/provider.dart';
import '../../Utils/auth.dart';
import '../../Utils/utils.dart';
import '../Providers/question_screen_provider.dart';
import '../Widgets/translated_text_widget.dart';

class beforequistion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      extendBody: true,
      body:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image(
                  image: AssetImage(
                    'assets/images/iconattention.png',
                  ),
                  width: 200,
          color:   const Color(0x88FF0202),
                ),
              ),
             Expanded(
               child: Padding(
                 padding: EdgeInsets.all(10),
                 child: Text('Dear donor...\n\n Before donating, you will ask several personal and sensitive questions, \nand we hope not to embarrass you.\n Your honest answers will ensure that the blood transfusion is as safe as possible.\n All information you provide will be treated confidentially.',
                    maxLines: 20,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.blueGrey[400],
                    ),

                  ),
               ),
             ),

              
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Theme.of(context).primaryColor,
                    elevation:15,
                    onPressed: () => {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                QuestionScreenProvider(),
                            child: const PreDonationScreen(),
                          ),
                        ),
                      )
                    },
                    child: const Text(
                      ' Go To Donation Quistion ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
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
