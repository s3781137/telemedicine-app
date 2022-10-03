// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Patient extends StatelessWidget {
  String username;
  Patient({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ND TELEMEDICINE'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: PopupMenuButton(
                child: Icon(Icons.account_circle),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'logout',
                      child: Text('Log out'),
                    ),
                    PopupMenuItem(
                      value: 'changePW',
                      child: Text('Change Password'),
                    ),
                    PopupMenuItem(
                      value: 'rmAccount',
                      child: Text('Delete account'),
                    ),
                  ];
                },
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // todo debug msg
                  print("passed username: $username");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Patient(username: username)));
                },
                child: Icon(Icons.home),
              )),
        ],
      ),
      body: BodyLayout(),
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
        onTap: () => Navigator.of(context).pushNamed('/patient/appointments'),
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
