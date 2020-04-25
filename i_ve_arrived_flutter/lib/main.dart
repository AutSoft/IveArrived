import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:i_ve_arrived/example/welcome_page.dart';
import 'package:i_ve_arrived/ui/login/login.dart';
import 'package:i_ve_arrived/ui/splash/splash.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new MyApp()
    },
  ));
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

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}