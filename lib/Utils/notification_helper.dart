import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Model/APIs/Notifications/notifications_api.dart';
import 'package:plasma/Model/Models/notification_model.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/View/Mobile/medical_results_screen.dart';
import 'package:plasma/View/Mobile/questionnaire.dart';
import 'package:plasma/View/Widgets/notification_widget.dart';

class NotificationHelper{
  static final FirebaseMessaging _instance = FirebaseMessaging.instance;
  static final String token = 'f7MyD7vrSMejWEb38VoupU:APA91bE-l-D0FTJtMuwQYb1KqD9B4vRD_YY-xcfbt5byWxTC81QJdxyOzN41_Ua49AmWOuEYFBFYwOjBR3j4zLAVbDCpS2zjy7yg3TPvyC-TeuD6U_s0-k67HkDm_192iPCjOSS7Z_QS';

  static bool _subscribed = false;
  static Future<void> messageHandler() async {
    await _instance.requestPermission(announcement: true,criticalAlert: true);
    await _instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true,);
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async{
    await Firebase.initializeApp(
      name: 'plasma',
      options: FirebaseOptions(
        apiKey: "AIzaSyDPzvjtXUhK21PNzHGdwtUk2DvQgMGtPfs",
        authDomain: "plasma-fecd2.firebaseapp.com",
        projectId: "plasma-fecd2",
        storageBucket: "plasma-fecd2.appspot.com",
        messagingSenderId: "951530390148",
        appId: "1:951530390148:web:05340ef570b71e7cc038d1",
      ),
    );
    //await AuthHelper.getUserData();
    //if (AuthHelper.currentUser == null) return;
    String title = message.notification!.title!;
    String body = message.notification!.body!;
    NotificationType type = NotificationType.values.byName('${message.data['type']}');
    NotificationModel model = NotificationModel(title: title, body: body, time: DateTime.now(), isOpened: false, type: type);
    await NotificationsApi().incrementNotifications(model);
  }

  static void onMessageOpenedApp(BuildContext context){
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (AuthHelper.currentUser == null) return;
      final String? type = message.data['type'];
      if (type == 'questionnaire'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuestionnaireScreen()));
      }
      if (type == 'medicalTestResult'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MedicalTestResultsScreen()));
      }
    });

  }



  static Future<void> subscribeToTopic(String topic) async{
    if (_subscribed) return;
    await _instance.subscribeToTopic(topic);
    _subscribed = true;
  }

  static Future<void> unsubscribeFromTopic(String topic) async{
    if (!_subscribed) return;
    await _instance.unsubscribeFromTopic(topic);
    _subscribed = false;
  }
}