import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class information extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
           SingleChildScrollView(
             child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
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
                            'images/Properties.png',
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'What is blood plasma?',
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
                      'Plasma is the main source for the manufacture of derivatives such as clotting factors, which is the only treatment for patients with chronic bleeding, such as "hemophilia".',
                     textAlign: TextAlign.left,
                      style: TextStyle(
                        
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                    // leading: Icon(
                    //   Icons.list,
                    // ),
                  ),
                  Divider(
                    indent: 35,
                    endIndent: 35,
                    thickness: 2,
                    color: Colors.amber,
                  ),
                   ListTile(
                    title: Text(
                      'Blood plasma is made from proteins that are important for the treatment of inflammatory patients, liver cancers and kidney patients.',
                     textAlign: TextAlign.left,
                      style: TextStyle(
                        
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                    // leading: Icon(
                    //   Icons.list,
                    // ),
                  ),
                      Divider(
                    indent: 35,
                    endIndent: 35,
                    thickness: 2,
                    color: Colors.amber,
                  ),
                   ListTile(
                    title: Text(
                      'Plasma consists of 92% water and 8% blood plasma proteins.',
                     textAlign: TextAlign.left,
                      style: TextStyle(
                        
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                    // leading: Icon(
                    //   Icons.list,
                    // ),
                  ),
                
                  
                ],
              ),
                  ),
           ),
    );
  }
}

