/// Tento kod sa stara o prihlasenie ucastnika.
/// Ucastnik do jednoducheho formulara vyplni prihlasovacie udaje ktorymi sa zapisal na put.
///
/// Tato Activity je cisto na prihlasenie.
/// Pri uspesnom prihlaseni sa ucastnik presunie na homepage.dart. Pri neuspesnom prihlaseni mu vyskoci upozornenie na nespavny email/heslo

import 'package:flutter/material.dart';

class Prihlasenie extends StatefulWidget {
  @override
  PrihlasenieState createState() {
    return PrihlasenieState();
  }
}

class PrihlasenieState extends State<Prihlasenie> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          title: new Text('Prihlásenie'),
        ),

        /// Form to login
        body: new Form(
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
                        onPressed: () {},
                        child: Text('Prihlásiť'),
                      ));
                    })),
              ]),
        ));
  }
}
