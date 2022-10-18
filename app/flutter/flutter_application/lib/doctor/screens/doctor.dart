import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/doctor/screens/add_avail.dart';
import 'package:flutter_application/doctor/screens/view_health_status.dart';
import 'package:flutter_application/doctor/screens/view_medication.dart';

import '../widget/appBar.dart';

class Doctor extends StatelessWidget {
  Doctor(this.jwt, this.payload);

  factory Doctor.fromBase64(String jwt) => Doctor(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context, jwt),
      body: ListView(
        children: <Widget>[
          ListTile(
            // todo: icon
            // leading: CircleAvatar(
            //   backgroundImage: AssetImage('assets/ManageProfile.png'),
            // ),
            title: const Text('Add availability'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddAvail.fromBase64(jwt)));
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/AddHealthInfo.png'),
            ),
            title: const Text('View Health Status'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ViewHealthStatusScreen.fromBase64(jwt)));
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/Medications.png'),
            ),
            title: const Text('Medications'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewMedicationScreen.fromBase64(jwt)));
            },
          ),
        ],
      ),
    );
  }
}
