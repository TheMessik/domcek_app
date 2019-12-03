/// Hlavna stranka, tu sa ucastnik dostane po prihlaseni.
///
/// Nazov je nazov aktualnej pute. Zobrazi sa program pute.
///
/// Cez drawer sa ucsstnik dostane k spatnej vazbe, moze odovzdat otazku pre hosta
/// a moderatori sa dostanu k otazkam pre hosta od ucastnikov.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  void initState(){
    super.initState();
  }

  List<String> program = [];
  final uID = "moderator";

  final title = "82. púť radosti: Rozumieš mi?";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("Tu príde program"),
      ),
      drawer: MyDrawer(uID),
    );
  }
}
