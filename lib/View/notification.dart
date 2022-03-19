import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading:  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back),),
          title: Text(
            "Notifications", style: TextStyle(fontSize: 20.0,),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search) )],
         // centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child:
                Text('There are no notifications', style: TextStyle(fontWeight: FontWeight.bold),)
              ),
          ),
          );
      
    
  }
}
