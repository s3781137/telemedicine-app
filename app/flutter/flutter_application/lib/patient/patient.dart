// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/model/patient_profile_model.dart';
import 'package:flutter_application/patient/screens/add_health_info.dart';
import 'package:flutter_application/patient/screens/profile.dart';
import 'package:flutter_application/patient/widgets/appbar.dart';

import 'core/api_patient.dart';
import 'model/patient_model.dart';

class Patient extends StatelessWidget {
  Patient({Key? key}) : super(key: key);
  final ApiClient _apiClient = ApiClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/ManageProfile.png'),
            ),
            title: Text('Manage Profile'),
            onTap: () async {
              PatientModel patient =
                  await _apiClient.getUser(currentLoggedInUser["username"]!);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Profile(
                        patient: patient,
                      )));
            },
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
            onTap: () => Navigator.of(context).pushNamed('/patient/medicine'),
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
