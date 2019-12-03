
/// Libraries
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Files
import 'feedBack.dart';
import 'questionsDownload.dart';
import 'questionsUpload.dart';
import 'homepage.dart';
import 'newMod.dart';

final server = 'ws://192.168.0.182:44332';

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.

void main() async{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final server = 'ws://192.168.0.172:44332';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Domcek",
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/questionsDownload': (context) => QuestionsDownload(server),
        '/feedback': (context) => FeedBack(server: server),
        '/questionsUpload': (context) => QuestionsUpload(server: server),
        '/homepage': (context) => HomePage(),
        '/newMod' : (context) => NewMod(),
      },
    );
  }
}
