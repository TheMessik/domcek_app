import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.uID);
  final String uID;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: _moderatorDrawer(context)));
  }

  List<Widget> _moderatorDrawer(context) {
    if (uID == "moderator") {
      return <Widget>[
        DrawerHeader(
          child: Text('Domček'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Spýtať sa otázku'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/ucastnikOtazka');
          },
        ),
        ListTile(
          title: Text('Spätná väzba'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/feedback');
          },
        ),
        ListTile(
            title: Text('Otázky pre hosťa'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/otazkyNaHosta');
            })
      ];
    } else {
      return <Widget>[
        DrawerHeader(
          child: Text('Domček'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Spýtať sa otázku'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/ucastnikOtazka');
          },
        ),
        ListTile(
          title: Text('Spätná väzba'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/feedback');
          },
        ),
      ];
    }
  }
}
