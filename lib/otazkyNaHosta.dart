/// SUMMARY:
/// tento kod sa stara o zobrazenie otazok, ktore budu polozene hostovi.
/// Ucastnici mozu tieto otazky posielat na server pomocou ucastnikOtazka.dart
///
/// Otazky su nasledne stiahnute zo servera pomocou HTTP socket request a zobrazene
///
/// Moderatori si mozu vyberat ktore otazky polozia. Tie ktore nechcu polozit mozu odstranit pomocou
/// potiahnutia dolava ci doprava. Otazky ale nie su odstranene zo servera. Pri dalsom socket request sa vsetky otazky nanovo nacitaju

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OtazkyNaHosta extends StatefulWidget {
  final server;
  OtazkyNaHosta(this.server);

  @override
  OtazkyNaHostaState createState() {
    return OtazkyNaHostaState(server);
  }
}

class OtazkyNaHostaState extends State<OtazkyNaHosta> {
  String server;
  WebSocketChannel channel;

  OtazkyNaHostaState(this.server);

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
