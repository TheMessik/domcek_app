
/// Libraries
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  final WebSocketChannel channel =
  IOWebSocketChannel.connect('ws://192.168.0.182:44332');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Domcek",
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/otazkyNaHosta': (context) => OtazkyNaHosta(channel),
        '/login': (context) => Prihlasenie(),
        '/feedback': (context) => FeedBack(channel: channel),
        '/ucastnikOtazka': (context) => UcastnikOtazka(channel: channel),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}
