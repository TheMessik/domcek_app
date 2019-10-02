/// SUMMARY:
/// tento kod sa stara o zobrazenie otazok, ktore budu polozene hostovi.
/// Ucastnici mozu tieto otazky posielat na server pomocou ucastnikOtazka.dart
///
/// Otazky su nasledne stiahnute zo servera pomocou HTTP socket request a zobrazene
///
/// Moderatori si mozu vyberat ktore otazky polozia. Tie ktore nechcu polozit mozu odstranit pomocou
/// potiahnutia dolava ci doprava. Otazky ale nie su odstranene zo servera. Pri dalsom socket request sa vsetky otazky nanovo nacitaju
///
/// TODO: po scrollnutí zhora dole nanovo načítať účastnícke otázky;
/// TODO: stiahnutie otázok zo servera pomocou WebSockets;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OtazkyNaHosta extends StatefulWidget {
  final socketChannelAddress;

  OtazkyNaHosta(this.socketChannelAddress);

  @override
  OtazkyNaHostaState createState() {
    return OtazkyNaHostaState(socketChannelAddress);
  }
}

class OtazkyNaHostaState extends State<OtazkyNaHosta> {
  /*final List<String> otazky = [
    "Ako sa mate?",
    "Co ste mali na obed?",
    "Chutilo Vam?"
  ];*/

  final socketChannelAddress;
  OtazkyNaHostaState(this.socketChannelAddress);

  @override
  Widget build(BuildContext context) {
    final title = 'Otazky na frajera z daleka';
    List<String> otazky;
    getQuestions();

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
          body: ListView.builder(
            itemCount: otazky.length,
            itemBuilder: (context, index) {
              final item = otazky[index];
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
                        otazky.removeAt(index);
                      });
                    }

                    // Then show a snackbar.
                    Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 200),
                        content: Text("Question dismissed")));
                  },

                  // Show a red background as the item is swiped away.
                  background: Container(color: Colors.red),
                  child: Container(
                      child: RefreshIndicator(
                          child: ListTile(
                              title: Center(child: Text('$item')),
                              onTap: () {
                                setState(() {
                                  //color = Colors.blue;
                                });
                              }),
                          onRefresh: _refreshList())));
            },
          ),
        ));
  }

  void getQuestions() {
    List<String> questions = [];
    var done = false;
    //WebSocketChannel channel = IOWebSocketChannel.connect('ws://192.168.0.182:44332');
    WebSocketChannel channel = IOWebSocketChannel.connect(socketChannelAddress);

    channel.stream.listen((message) {
      if (message == "Ready") {
        channel.sink.add("ask_guest");
        while (!done) {
          channel.stream.listen((question) {
            if (question == "done") {
              done = true;
            }
            questions.add(question);
          });
        }
      }
    });
    /*questions.add("Ako sa mate?");
    questions.add("Co robite?");
    questions.add("Kedy ste prisli?");
    questions.add("How much wood would a woodchuck chuck if a woodchuck could chuck wood?");
    questions.add("Preco sa musim ucit matiku ked chcem studovat informatiku?");
    questions.add("Inak vsetko v poho?");*/
  }

  _refreshList() {
    setState(() {
      getQuestions();
    });
  }
}
