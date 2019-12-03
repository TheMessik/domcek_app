/// SUMMARY:
/// Code takes care of the download and the showing of the questions from the participants to the guest
/// Participants can upload these questions using questionsUpload.dart
///
/// Questions are downloaded using HTTP socket request
///
/// Mods can choose which questions they want to ask.
/// Questions they don't like should be dismissed by swiping left or right
/// Questions do not need to get removed from the server. By pulling down on the list of the questions, it should be refreshed

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class QuestionsDownload extends StatefulWidget {
  final server;
  QuestionsDownload(this.server);

  @override
  QuestionsDownloadState createState() {
    return QuestionsDownloadState(server);
  }
}

class QuestionsDownloadState extends State<QuestionsDownload> {
  String server;
  WebSocketChannel channel;

  QuestionsDownloadState(this.server);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Otazky na frajera z daleka';
    channel = IOWebSocketChannel.connect(server);
    channel.sink.add("askGst");
    List<String> questions = new List();

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                questions.add(snapshot.data);

                return ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, counter) {
                    print(questions[counter]);
                    return new ListTile(

                      title: new Center(child: Text('${questions[counter]}')),
                    );
                  },
                );
              } else {
                print(snapshot.data);
                return new Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
