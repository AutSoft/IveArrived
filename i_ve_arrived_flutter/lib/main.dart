import 'dart:isolate';

import 'package:android_intent/android_intent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:i_ve_arrived/example/welcome_page.dart';
import 'package:i_ve_arrived/ui/login/login.dart';

FirebaseMessaging firebaseMessaging = FirebaseMessaging();

var lastMessageNotifier = ValueNotifier<Map<String, dynamic>>({});

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  firebaseMessaging.configure(
    onMessage: (message) async{
      lastMessageNotifier.value = message;
    },
    onLaunch: (message) async {
      print("Launch");
      print(message);
    },
    onResume: (message) async {
      print("Resume");
      print(message);
    },
    onBackgroundMessage: myBackgroundMessageHandler,
  );
  runApp(MyApp());
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  lastMessageNotifier.value = message;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, null);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: null);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', 'channel_name', 'channel_description',
      importance: Importance.Max, priority: Priority.High, playSound: false);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Hello',
    'World!',
    platformChannelSpecifics,
  );

  /*FlutterRingtonePlayer.playAlarm();
  await Future.delayed(Duration(seconds: 30));
  FlutterRingtonePlayer.stop();*/

  /*WidgetsFlutterBinding.ensureInitialized();
  FlutterRingtonePlayer.playAlarm();
  await Future.delayed(Duration(seconds: 5));
  FlutterRingtonePlayer.stop();

  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  return;*/
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class RingtonePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text("Start"),
              onPressed: (){
                FlutterRingtonePlayer.playAlarm();
              },
            ),
            RaisedButton(
              child: Text("Stop"),
              onPressed: (){
                FlutterRingtonePlayer.stop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Route<T> route<T>(Widget Function() pageBuilder) => routeContext((_) => pageBuilder());
Route<T> routeContext<T>(Widget Function(BuildContext) pageBuilder) => MaterialPageRoute<T>(builder: (context) => pageBuilder(context));
var isDeliveryMode = true;

const kDefaultAnimationDuration = Duration(milliseconds: 200);
const kDefaultAnimationCurve = Curves.easeOut;

/*Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings(null);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, null);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, null);
  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', platformChannelSpecifics,
      payload: 'item x');
  /*WidgetsFlutterBinding.ensureInitialized();
  FlutterRingtonePlayer.playAlarm();
  await Future.delayed(Duration(seconds: 5));
  FlutterRingtonePlayer.stop();

  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  return;*/
}

Future selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
}*/