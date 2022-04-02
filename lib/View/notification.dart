import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> bottomBarKey;
  const NotificationScreen({Key? key, required this.bottomBarKey}) : super(key: key);

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
        leading: GestureDetector(
          onTap: () => widget.bottomBarKey.currentState?.setPage(3),
          child: Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.amber,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        // centerTitle: true,
        elevation: 0.0,
      ),
      extendBody: true,
      body: Center(
        child: SizedBox(
          width: 220,
          height: 220,
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
        ),
      ),
    );
  }
}
