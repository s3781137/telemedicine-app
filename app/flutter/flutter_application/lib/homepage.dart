// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/appointments.dart';
import 'welcome.dart';
import 'screens/view_appointment.dart';
import 'screens/cancel_appointment.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homepage': (context) => Homepage(),
        '/welcome': (context) => const WelcomeScreen(),
        '/appointments': (context) => AppointmentsScreen(),
        '/viewappointment': (context) => ViewAppointmentScreen(),
        '/cancelappointment': (context) => CancelAppointmentScreen(),
      },
      title: 'ListViews',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ND TELEMEDICINE'),
          // todo: top right button click behaviour
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.account_circle),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/homepage');
                  },
                  child: Icon(Icons.home),
                )),
          ],
        ),
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
        onTap: () => Navigator.of(context).pushNamed('/appointments'),
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
