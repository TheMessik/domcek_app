/// Main page
/// 'title' is the title of the currect action
/// the body is made up of the planned program of the action
///
/// Using drawer, the user can reach the Feedback form and post their questions for the guest speaker
/// mods can also download and read these questions

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

  final title = "testTitle";

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
