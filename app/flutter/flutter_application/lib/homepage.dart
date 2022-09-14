// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'signIn.dart';
import 'welcome.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homepage': (context) => Homepage(),
        '/welcome': (context) => const WelcomeScreen(),
      },
      title: 'ListViews',
      home: Scaffold(
        appBar: AppBar(title: Text('ND TELEMEDICINE')),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    // ignore: prefer_const_literals_to_create_immutables
    children: <Widget>[
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/ManageProfile.png'),
        ),
        title: Text('Manage Profile'),
        onTap: () => Navigator.of(context).pushNamed('/welcome'),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/AddHealthInfo.png'),
        ),
        title: Text('Add Health Information'),
        onTap: () => Navigator.of(context).pushNamed('/welcome'),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/Appointments.png'),
        ),
        title: Text('Appointments'),
        onTap: () => Navigator.of(context).pushNamed('/welcome'),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/Medications.png'),
        ),
        title: Text('Medications'),
        onTap: () => Navigator.of(context).pushNamed('/welcome'),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/Chat.png'),
        ),
        title: Text('Chat With A Doctor'),
        onTap: () => Navigator.of(context).pushNamed('/welcome'),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/AddSymptoms.png'),
        ),
        title: Text('Add Symptoms'),
        onTap: () => Navigator.of(context).pushNamed('/welcome'),
      ),
    ],
  );
}