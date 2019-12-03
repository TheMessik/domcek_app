/// SUMMARY:
/// tento kod sa stara o zobrazenie otazok, ktore budu polozene hostovi.
/// Ucastnici mozu tieto otazky posielat na server pomocou questionsUpload.dart
///
/// Otazky su nasledne stiahnute zo servera pomocou HTTP socket request a zobrazene
///
/// Moderatori si mozu vyberat ktore otazky polozia. Tie ktore nechcu polozit mozu odstranit pomocou
/// potiahnutia dolava ci doprava. Otazky ale nie su odstranene zo servera. Pri dalsom socket request sa vsetky otazky nanovo nacitaju
///
/// TODO: po scrollnutí zhora dole nanovo načítať účastnícke otázky;
/// TODO: stiahnutie otázok zo servera pomocou WebSockets;

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
  /*final List<String> otazky = [
    "Ako sa mate?",
    "Co ste mali na obed?",
    "Chutilo Vam?"
  ];*/
  String server;
  WebSocketChannel channel;
  OtazkyNaHostaState(this.server);

  final otazky = List<String>();
  var removed = List<String>();

  void initState(){
    super.initState();
    channel = IOWebSocketChannel.connect(server);
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Otazky na frajera z daleka';

    //Color color = Colors.transparent;
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
                channel.sink.add("askGst");

                otazky.add(snapshot.hasData ? snapshot.data : '');
                print(otazky);
                dispose();

                return ListView.builder(
                  itemCount: otazky.length,
                  itemBuilder: (context, index) {
                    final item = otazky[index];
                    var removed = List<String>();
                    return Dismissible(
                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                        key: Key(UniqueKey().toString()),
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                          if (direction == DismissDirection.horizontal) {
                            // Remove the item from the data source.
                            setState(() {
                              removed.add(otazky[index]);
                              otazky.removeAt(index);
                            });
                          }
                          // Show a snackbar in case user wants to undo the dismiss
                          Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 200),
                              content: Text("Question dismissed"),
                            action: SnackBarAction(
                              label: "Undo",
                              onPressed: undoDismiss
                            )
                          ),
                          );
                        },

                        // Show a red background as the item is swiped away.
                        background: Container(color: Colors.red),
                        child: Container(
                            child: ListTile(
                                    title: Center(child: Text('$item')),
                                    onTap: () {
                                    })));
                               // onRefresh: _refreshList())));
                  },
                );


              })),

    );
  }

  void undoDismiss(){
    otazky.addAll(removed);
    removed.clear();
  }


  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
