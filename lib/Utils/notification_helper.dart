import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/View/Mobile/questionnaire.dart';

class NotificationHelper{
  static final FirebaseMessaging _instance = FirebaseMessaging.instance;
  static final String token = 'f7MyD7vrSMejWEb38VoupU:APA91bE-l-D0FTJtMuwQYb1KqD9B4vRD_YY-xcfbt5byWxTC81QJdxyOzN41_Ua49AmWOuEYFBFYwOjBR3j4zLAVbDCpS2zjy7yg3TPvyC-TeuD6U_s0-k67HkDm_192iPCjOSS7Z_QS';

  static Future<void> messageHandler() async {
    await _instance.requestPermission(announcement: true,criticalAlert: true);
    await _instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true,);
  }

  static void onMessageOpenedApp(BuildContext context){
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (AuthHelper.currentUser == null) return;
      final String? type = message.data['type'];
      if (type == 'questionnaire'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuestionnaireScreen()));
      }
    });
  }

  static Future<void> subscribeToTopic(String topic) async{
    await _instance.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async{
    await _instance.unsubscribeFromTopic(topic);
  }
}