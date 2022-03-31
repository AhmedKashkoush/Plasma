import 'package:flutter/material.dart';

class benefits extends StatelessWidget {
  const benefits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(title: Text('Benefits Of Plasma Donation'),foregroundColor: Colors.white,),
        body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.only(top:50),
    child: SingleChildScrollView(
    child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.amber),color: Colors.amber
          ),
          child: Text('Benefits For The Donor',textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:22,color: Colors.white
            ),),
        ),
      ),
      SizedBox(
        height:height*0.01,
      ),
              Container(width: 500,height: 220,color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 290,
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[ Text('* Doing the analysis of acquired immunodeficiency (AIDS) and syphilis on a regular basis.',
                      style:TextStyle(fontSize:18)),
                      Text('* Blood protein analysis every 4 months',style:TextStyle(fontSize:18)),
                      Text('* Hepatitis A,B, C virus analysis',style:TextStyle(fontSize:18)),
                      Text('* Bone marrow activation',style:TextStyle(fontSize:18)),
                      Text('* Strengthen the immune system',style:TextStyle(fontSize:18))
                    ]
            ),
                ),

                      Container(
                    width:120,
                          child: Column(
                              children:[ Image(image:AssetImage('images/analyzing.jpeg'),
                              ),
                                Image(image:AssetImage('images/ph.jpeg') ,)
                              ]

                          )

                  ),
        ]
                )
                 ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.amber),color: Colors.amber
          ),
          child: Text('Benefits For Patients',textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:22,color: Colors.white
            ),),
        ),
      ),
      SizedBox(
        height:height*0.01,
      ),

      Container(width: 500,height: 220,color: Colors.white,
          child: Row(
              children: [
                Container(
                  width: 250,
                  padding: EdgeInsets.only(left: 10),
                  child: Text('* Providing safe treatment and avoiding complications that occur as a result of the lack of necessary treatment such as joint obstruction for bleeding patients, avoiding cirrhosis and kidney failure for chronic viral hepatitis patients.',
                  style: TextStyle(fontSize: 18),
                  ),
                ),

                Container(
                    width:160,
                  child: Image(image:AssetImage('images/heart.jpeg'),
                  ),

                ),
              ]
          )
      ),
    ]))))
    );
  }

}
