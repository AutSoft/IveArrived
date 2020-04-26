import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:android_intent/android_intent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_ve_arrived/example/welcome_page.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/login/login.dart';
import 'package:i_ve_arrived/ui/main/main.dart';
import 'package:i_ve_arrived/ui/splash/splash.dart';
import 'package:path_provider/path_provider.dart';

FirebaseMessaging firebaseMessaging = FirebaseMessaging();

var lastMessageNotifier = ValueNotifier<Map<String, dynamic>>({});
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, null);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotificationCallback);

  firebaseMessaging.configure(
    onMessage: (message) async{
      print("MESSAGE");
      print(message);
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

  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  service = Service(tempPath);
  runApp(MyApp());
}

Future<dynamic> selectNotificationCallback(String payload){
  var message = jsonDecode(payload);
  lastMessageNotifier.value = message;
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, null);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotificationCallback);
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
    payload: jsonEncode(message),
  );

  FlutterRingtonePlayer.playAlarm();
  await Future.delayed(Duration(seconds: 30));
  FlutterRingtonePlayer.stop();

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
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.heeboTextTheme(Theme.of(context).textTheme),
      ),
      home: service.hasAccessToken() ? MainPage() : SplashScreen(),
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
const placeholderProfileUrl = "https://organicthemes.com/demo/profile/files/2018/05/profile-pic.jpg";