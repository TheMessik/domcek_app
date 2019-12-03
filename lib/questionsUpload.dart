/// SUMMARY:
/// Pomocou tejto aktivity môžu účastníci odovzdať otázky ktoré majú na hosťa
///
/// Using a simple form, participants have the option to upload their questions
/// for the guest. These questions are uploaded to the server.
///
/// Mods can download these questions.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class QuestionsUpload extends StatefulWidget {
  final String server;
  QuestionsUpload({Key key, this.server}) : super(key: key);

  @override
  QuestionsUploadState createState() {
    return QuestionsUploadState(server);
  }
}

class QuestionsUploadState extends State<QuestionsUpload> {
  String server;
  WebSocketChannel channel;
  final _controller = TextEditingController();

  QuestionsUploadState(this.server);

  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(server);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("questions upload"),
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
