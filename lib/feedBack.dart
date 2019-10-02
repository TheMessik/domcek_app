/// Tento kód sa stará o spätnú väzbu. Užívateľ sa k tomuto kódu dostane cez drawer.
/// Jedná sa o jednoduchý formulár, v ktorom užívateľ odpovedá na 3 otázky:
///
/// 1. Čo som si uvedomil/-a počas tejto akcie?
/// 2. Aké impulzy do života som prijal/-a?
/// 3. Môj odkaz:
///
/// Po kliknutí na RaisedButton "Odovzdať" sú otázky uložené do array a následne
/// poslané na server pomocou WebSockets.
///
/// TODO: Posielanie otázok účastníkov na server pomocou WebSockets

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';

class FeedBack extends StatefulWidget {
  final socketChannelAddress;
  FeedBack({Key key, @required this.socketChannelAddress}) : super(key: key);

  @override
  FeedBackState createState() {
    return FeedBackState(socketChannelAddress);
  }
}

class FeedBackState extends State<FeedBack> {
  final controllerQ1 = TextEditingController();
  final controllerQ2 = TextEditingController();
  final controllerQ3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var otazky = [];

  final socketChannelAddress;

  FeedBackState(this.socketChannelAddress);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Spätná väzba"),
      ),
      body: new Form(
        key: _formKey,
        child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              /// Otazka c.1
              new TextFormField(
                controller: controllerQ1,
                decoration: InputDecoration(
                    labelText: 'Čo som si uvedomil/-a počas tejto akcie?'),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Prosím, povedz náám :)";
                  }
                  return null;
                },
              ),

              /// Otazka c.2
              new TextFormField(
                controller: controllerQ2,
                decoration: InputDecoration(
                    labelText: 'Aké impulzy do života som prijal/-a?'),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Prosím, povedz náám :)";
                  }
                  return null;
                },
              ),

              /// Otazka c.3
              new TextFormField(
                controller: controllerQ3,
                decoration: InputDecoration(labelText: 'Môj odkaz:'),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Prosím, povedz nááám :)";
                  }
                  return null;
                },
              ),
              new RaisedButton(
                  onPressed: () {
                    addToArray(otazky, controllerQ1.text, controllerQ2.text,
                        controllerQ3.text);
                    print(otazky);
                    sendData();
                  },
                  child: Text("Odovzdať")),
            ]),
      ),
    );
  }

  void addToArray(List array, String q1, String q2, String q3) {
    array.clear();
    array.add(q1);
    array.add(q2);
    array.add(q3);
  }

  void sendData() {
    WebSocketChannel channel = IOWebSocketChannel.connect(socketChannelAddress);
    channel.stream.listen((message) {
      if (message == "Ready") {
        channel.sink.add("feedback");
        channel.sink.add(otazky[0]);
        sleep(const Duration(milliseconds: 200));
        print("sending 1");
        channel.sink.add(otazky[1]);
        print("sending 2");
        channel.sink.add(otazky[2]);
        print("sending 3");
        channel.sink.close(1000);
      }
    });
  }
}
