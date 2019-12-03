/// Activity for the admins only
///
/// This activity might be used change the server settings, change the password
/// mods need to access questions etc.
///
/// To be determined whether or not to include in the final release

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