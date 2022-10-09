// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/patient/screens/add_health_info.dart';

class Patient extends StatelessWidget {
  Patient({Key? key}) : super(key: key);

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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Patient()));
                },
                child: Icon(Icons.home),
              )),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/ManageProfile.png'),
            ),
            title: Text('Manage Profile'),
            onTap: () => Navigator.of(context).pushNamed('/patient/profile'),
          ),
          ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/AddHealthInfo.png'),
              ),
              title: Text('Add Health Information'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PatientHealthInfo()))),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Appointments.png'),
            ),
            title: Text('Appointments'),
            onTap: () =>
                Navigator.of(context).pushNamed('/patient/appointments'),
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
      ),
    );
  }
}
