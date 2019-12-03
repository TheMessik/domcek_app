/// Code serves to give feedback of the action.
/// A simple form to answer three questions, questions that are coded now are for
/// development only
///
/// After clicking the RaisedButton "Odovzdat", the questions will be put into an array
/// and sent off to the backend server
///
/// TODO: Send questions to the server using WebSockets

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class FeedBack extends StatefulWidget {
  final server;
  FeedBack({Key key, @required this.server}) : super(key: key);

  @override
  FeedBackState createState() {
    return FeedBackState(server);
  }
}

class FeedBackState extends State<FeedBack> {
  String server;
  WebSocketChannel channel;
  final controllerQ1 = TextEditingController();
  final controllerQ2 = TextEditingController();
  final controllerQ3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FeedBackState(this.server);

  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(server);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Feedback"),
      ),
      body: new Form(
        key: _formKey,
        child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              /// Questions n1
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

              /// Question n2
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

              /// Questions n3
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
                    if(_formKey.currentState.validate()) {
                      sendData();
                      Navigator.pop(context);
                    }
                  },
                  /// "Odovzdat" = submit
                  child: Text("Odovzdať")),
            ]),
      ),
    );
  }
  void sendData() {
    String q1 = controllerQ1.text;
    String q2 = controllerQ2.text;
    String q3 = controllerQ3.text;
    var command = "feedBK";
    var lengthQ1 = q1.length;
    var lengthQ2 = q2.length;
    var lengthQ3 = q3.length;

    String data = command;

    /// Q1
    if (lengthQ1 > 9) {
      data += "2";
    } else if (lengthQ1 > 99) {
      data += "3";
    } else {
      data += "1";
    }
    data += lengthQ1.toString() + q1;

    /// Q2
    if (lengthQ2 > 9) {
      data += 2.toString();
    } else if (lengthQ2 > 99){
      data += 3.toString();
    } else {
      data += 1.toString();
    }
    data += lengthQ2.toString() + q2;

    /// Q3
    if(lengthQ3 > 9) {
      data += 2.toString();
    } else if(lengthQ3 > 99) {
      data += 3.toString();
    } else {
      data += 1.toString();
    }
    data += lengthQ3.toString() + q3;

    print(data);
    channel.sink.add(data);
    channel.sink.close();
  }
}
