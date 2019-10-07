/// SUMMARY:
/// Pomocou tejto aktivity môžu účastníci odovzdať otázky ktoré majú na hosťa

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UcastnikOtazka extends StatefulWidget {
  String server;
  UcastnikOtazka({Key key, this.server}) : super(key: key);

  @override
  UcastnikOtazkaState createState() {
    return UcastnikOtazkaState(server);
  }
}

class UcastnikOtazkaState extends State<UcastnikOtazka> {
  String server;
  WebSocketChannel channel;
  final _controller = TextEditingController();

  UcastnikOtazkaState(this.server);

  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(server);
  }

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
              stream: channel.stream,
              builder: (context, snapshot) {
                return Text("");
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
      channel.sink.add(data);
      print(data);
      channel.sink.close(1000);
      Navigator.pop(context);
    }
  }

}
