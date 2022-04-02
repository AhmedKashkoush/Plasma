import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text(
            "Notifications",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          // centerTitle: true,
          elevation: 0.0,
        ),
        extendBody: true,
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.6,
                child: Image(
                  image: AssetImage('images/noNotification.png'),
                  width: 220,
                ),
              ),
              Text(
                'No new notifications',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              )
            ],
          ),
        ),
    );
  }
}
