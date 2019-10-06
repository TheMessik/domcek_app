/// SUMMARY:
/// Pomocou tejto aktivity môžu účastníci odovzdať otázky ktoré majú na hosťa

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UcastnikOtazka extends StatefulWidget {
  final WebSocketChannel channel;
  UcastnikOtazka({Key key, @required this.channel}) : super(key: key);

  @override
  UcastnikOtazkaState createState() {
    return UcastnikOtazkaState();
  }
}

class UcastnikOtazkaState extends State<UcastnikOtazka> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otázka pre hosťa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? snapshot.data : "");
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {

    if (_controller.text.isNotEmpty) {
      var data = "qGuest" + _controller.text;
      widget.channel.sink.add(data);
      print(data);
      _controller.text = "";
      widget.channel.sink.close(1000);
      Navigator.pop(context);

    }
  }

  /*@override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }*/
}
