import 'package:flutter/cupertino.dart';

/// Tento kod sa stara o prihlasenie ucastnika.
/// Ucastnik do jednoducheho formulara vyplni prihlasovacie udaje ktorymi sa zapisal na put.
///
/// Tato Activity je cisto na prihlasenie.
/// Pri uspesnom prihlaseni sa ucastnik presunie na homepage.dart. Pri neuspesnom prihlaseni mu vyskoci upozornenie na nespavny email/heslo

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Prihlasenie extends StatefulWidget {
  final String server;

  Prihlasenie({Key key, @required this.server}) : super(key: key);
  @override
  PrihlasenieState createState() {
    return PrihlasenieState(server);
  }
}

class PrihlasenieState extends State<Prihlasenie> {
  var role;
  final server;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  PrihlasenieState(this.server);


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Vitaj! Prihlás sa prosím :)'),
      ),

      /// Form to login
      body: Container(
        color: Colors.lightBlueAccent,
        child: new Form(
          key: _formKey,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              /// Username
              new TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Bez mailu to nepôjde";
                  }
                  return null;
                },
              ),

              /// Password
              new TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Heslo',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Bez hesla to nepôjde';
                  }
                  return null;
                },
              ),

              /// Submit button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Builder(builder: (BuildContext context) {
                  return Center(
                    child: RaisedButton(
                      onPressed: () {
                        _login(emailController.text, passwordController.text);
                      },
                      child: Text('Prihlásiť sa'),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(String email, String password){
    WebSocketChannel channel = IOWebSocketChannel.connect(server);
    channel.sink.add('login');
    channel.sink.add(email);
    channel.sink.add(password);
    channel.stream.listen((response){
      if(response == "unknown"){
        print("unknown credentials");
      }
      else{
        role = response;
      }

    });
  }
}
