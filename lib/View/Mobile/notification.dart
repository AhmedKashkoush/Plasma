import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/View/Widgets/blood_loading.dart';
import 'package:plasma/View/Widgets/notification_widget.dart';
import 'package:plasma/ViewModel/notifications_view_model.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            child:  AuthHelper.currentUser?.image != null &&
                AuthHelper.currentUser?.image != ""
                ? Transform.scale(
                    scale: 0.5,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(
                        '${AuthHelper.currentUser?.image}',
                        cacheKey: '${AuthHelper.currentUser?.image}',
                      ),
                    ),
                  )
                : Icon(
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
                return ChangeNotifierProvider(
                  create: (BuildContext context) => NotificationsViewModel(),
                  child: NotificationsPage(),
                );
            }
            return NoInternetPage(
              onRefresh: () {
                setState(() {
                  _future = null;
                });
                _future = Connectivity().checkConnectivity();
              },
            );
          },
        ));
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Future? _future;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
    //   final _notificationsVM = Provider.of<NotificationsViewModel>(context,listen: false);
    //   _future = await _notificationsVM.loadNotifications(_notificationsVM.limit);
    //   _scrollController.addListener(() {
    //     double maxScrollExtent = _scrollController.position.maxScrollExtent;
    //     double currentPosition = _scrollController.position.pixels;
    //     int listLength = _notificationsVM.notificationsList.length;
    //     final int limit = _notificationsVM.limit;
    //     if (listLength >= limit) {
    //       if (currentPosition >= maxScrollExtent / 2)
    //         _notificationsVM.loadMoreNotifications(limit);
    //     }
    //   });
    // });
  }

  @override
  void didChangeDependencies() {
    final _notificationsVM =
        Provider.of<NotificationsViewModel>(context, listen: false);
    if (_future == null) {
      _future = _notificationsVM.loadNotifications(_notificationsVM.limit);
    }
    _scrollController.addListener(() async {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double currentPosition = _scrollController.position.pixels;
      int listLength = _notificationsVM.notificationsList.length;
      final int limit = _notificationsVM.limit;
      if (listLength >= limit) {
        if (currentPosition >= maxScrollExtent * 0.7) {
          await _notificationsVM.loadMoreNotifications(20);
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _notificationsVM =
        Provider.of<NotificationsViewModel>(context, listen: false);
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ListView.builder(
            itemCount: 40,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => NotificationLoadingWidget(),
          );
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError)
            return Container(
              color: Colors.red,
            );
          int length = _notificationsVM.notificationsList.length;
          if (length == 0)
            return NoNotificationsPage(
              onCall: () async {
                await _cacheImage(
                    AssetImage('assets/images/noNotification.png'), context);
              },
            );
          return RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              await Future.delayed(
                const Duration(seconds: 1),
              );
              setState(() {
                _future = null;
              });
              _future = _notificationsVM.refresh();
            },
            child: Consumer<NotificationsViewModel>(
              builder: (BuildContext context, provider, Widget? child) =>
                  ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  //int _rand = Random().nextInt(_types.length);
                  if (index < provider.notificationsList.length)
                    return NotificationWidget(
                      title: provider.notificationsList[index].title,
                      //'Reminder',
                      body: provider.notificationsList[index].body,
                      time: provider.notificationsList[index].time,
                      type: provider.notificationsList[index].type,
                      isOpened: provider.notificationsList[index].isOpened,
                      onTap: () {
                        setState(() {
                          provider.notificationsList[index].isOpened = true;
                        });
                      },
                    );
                  return provider.isLoading
                      ? const NotificationLoadingWidget()
                      : const SizedBox.shrink();
                  // return Center(
                  //   child: Text('${provider.isLoading}'),
                  // );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                ),
                itemCount: provider.notificationsList.length + 1,
              ),
            ),
          );
        }
        return Center(
          child: Text('$_future'),
        );
      },
    );
  }

  // Future<List>? _triggerNotificationsCall() async {
  //   await Future.delayed(
  //     const Duration(seconds: 6),
  //   );
  //   return _list =
  //       List<String>.generate(Random().nextInt(20), (index) => '$index')
  //           .toList();
  // }

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

class NoInternetPage extends StatelessWidget {
  final VoidCallback onRefresh;

  const NoInternetPage({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

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
                  image: AssetImage('assets/images/no-internet.png'),
                  width: 220,
                ),
              ),
              TranslatedTextWidget(
                text: 'Check Your Internet Connection',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              TextButton.icon(
                onPressed: onRefresh,
                icon: Icon(
                  Icons.refresh,
                ),
                label: TranslatedTextWidget(
                  text: 'Refresh',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
