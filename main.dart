
/// Libraries
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Files
import 'feedBack.dart';
import 'prihlasenie.dart';
import 'otazkyNaHosta.dart';
import 'ucastnikOtazka.dart';
import 'homepage.dart';

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.

void main() {
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
  final server = 'ws://192.168.0.189:44332';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Domcek",
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/otazkyNaHosta': (context) => OtazkyNaHosta(server),
        '/login': (context) => Prihlasenie(),
        '/feedback': (context) => FeedBack(server: server),
        '/ucastnikOtazka': (context) => UcastnikOtazka(server: server),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}
