/// SUMMARY:
/// Pomocou tejto aktivity môžu účastníci odovzdať otázky ktoré majú na hosťa

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:io';

class UcastnikOtazka extends StatefulWidget {
  final socketChannelAddress;
  UcastnikOtazka({Key key, @required this.socketChannelAddress})
      : super(key: key);

  @override
  UcastnikOtazkaState createState() {
    return UcastnikOtazkaState(socketChannelAddress);
  }
}

class UcastnikOtazkaState extends State<UcastnikOtazka> {
  final socketChannelAddress;
  final _controllerQ1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  UcastnikOtazkaState(this.socketChannelAddress);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Otázka pre hosťa"),

      ),
      body:
        new Form(
          key: _formKey,
          child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                /// Otazka pre hosta
                new TextFormField(
                  controller: _controllerQ1,
                  decoration: InputDecoration(labelText: 'Otazka pre hosťa'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Chýba mi tu otázka";
                    }
                    return null;
                  },
                ),

                /// Tlacitko odovzdat
                new RaisedButton(
                    onPressed: () {
                      _sendData();
                      _showDialog();

                    },
                    child: Text("Odovzdať"))
              ])));

  }

  void _sendData() {
    WebSocketChannel channel = IOWebSocketChannel.connect(socketChannelAddress);
    channel.stream.listen((message) {
      if (message == "Ready") {
        channel.sink.add("question_for_guest");
        sleep(const Duration(seconds: 1));
        print(_controllerQ1.text);
        channel.sink.add(_controllerQ1.text);
        channel.sink.close();
      }
    });


  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                new CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text("Spracúvam"),
                )
              ]
            )
          )


        );

      } );

    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context);
      _controllerQ1.clear();

    });
  }
}
