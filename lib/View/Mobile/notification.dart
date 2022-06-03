import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasma/View/Widgets/blood_loading.dart';
import 'package:plasma/View/Widgets/notification_widget.dart';

import '../Widgets/translated_text_widget.dart';

class NotificationScreen extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> bottomBarKey;

  const NotificationScreen({Key? key, required this.bottomBarKey})
      : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<ConnectivityResult>? _future;

  @override
  void initState() {
    if (mounted) _future = Connectivity().checkConnectivity();
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
        body: FutureBuilder<ConnectivityResult>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: BloodLoadingIndicator(),
              );
            else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != ConnectivityResult.none)
                return NotificationsPage();
            }
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

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Future<List>? _future;
  List<String> _list = [];
  final List<String> _types = [
    'reservation',
    'reminder',
    'questionnaire',
    'analysisResult',
    'bonus',
    'auth',
    'user',
  ];

  @override
  void initState() {
    _future = _triggerNotificationsCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _future,
      builder: (context, AsyncSnapshot<List>snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ListView.builder(
            itemCount: 40,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => NotificationLoadingWidget(),
          );
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            int length = snapshot.data!.length;
            if (length == 0) return NoNotificationsPage(
              onCall: () async {
                await _cacheImage(
                    AssetImage('assets/images/noNotification.png'), context);
              },
            );
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                await Future.delayed(
                  const Duration(seconds: 3),
                );
                setState(() {
                  _future = null;
                });
                _future = _triggerNotificationsCall();
              },
              child: ListView.separated(
                itemBuilder: (context, index) {
                  int _rand = Random().nextInt(_types.length);
                  return NotificationWidget(
                    title: _types[_rand], //'Reminder',
                    body:
                        'ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
                    time: DateTime.now(),
                    type: NotificationType.values.byName(_types[_rand]),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                ),
                itemCount: length,
              ),
            );
          }
          if (snapshot.hasError) return Container(color: Colors.red,);
        }
        return NoNotificationsPage(
          onCall: () async {
            await _cacheImage(
                AssetImage('assets/images/noNotification.png'), context);
          },
        );
      },
    );
  }

  Future<List>? _triggerNotificationsCall() async {
    await Future.delayed(
      const Duration(seconds: 6),
    );
    return _list = List<String>.generate(Random().nextInt(20), (index) => '$index')
        .toList();
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
