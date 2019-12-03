import 'package:flutter/material.dart';

class NewMod extends StatefulWidget{
  NewMod({Key key}) : super(key: key);

  @override
  NewModState createState(){
    return NewModState();
  }
}

class NewModState extends State<NewMod>{
  @override
  Widget build(BuildContext context){
    return Center(
      child: Text("Hello World"),
    );
  }
}