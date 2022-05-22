import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/Widgets/blood_loading.dart';

import '../Widgets/translated_text_widget.dart';

class NotificationScreen extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> bottomBarKey;

  const NotificationScreen({Key? key, required this.bottomBarKey})
      : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future? _future;

  @override
  void initState() {
    if (mounted)
      _future = Future.delayed(
        const Duration(seconds: 5),
      );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.grey.shade800,
          foregroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          title: TranslatedTextWidget(
            text: "Notifications",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          leading: GestureDetector(
            onTap: () => widget.bottomBarKey.currentState?.setPage(3),
            child: Icon(
              Icons.account_circle,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          // centerTitle: true,
          elevation: 0.0,
        ),
        extendBody: true,
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: BloodLoadingIndicator(),
              );
            return NoNotificationsPage(
              onCall: () async {
                await _cacheImage(
                    AssetImage('assets/images/noNotification.png'), context);
              },
            );
          },
        ));
  }

  Future<void> _cacheImage(
      ImageProvider imageProvider, BuildContext context) async {
    await precacheImage(imageProvider, context);
  }
}

class NoNotificationsPage extends StatelessWidget {
  final VoidCallback onCall;

  const NoNotificationsPage({Key? key, required this.onCall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  image: AssetImage('assets/images/noNotification.png'),
                  width: 220,
                ),
              ),
              TranslatedTextWidget(
                text: 'No New Notifications',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
