import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/screens/doctor_profile.dart';
import 'package:flutter_application/doctor/core/api_doctor.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/core/api_patient.dart';
import 'package:flutter_application/patient/model/patient_model.dart';
import 'package:flutter_application/patient/model/patient_symptoms_model.dart';
import 'package:flutter_application/patient/model/petient_health_model.dart';
import '../model/doctor_model.dart';
import '../widget/appBar.dart';

class ViewSymptomsScreen extends StatefulWidget {
  const ViewSymptomsScreen(this.jwt, this.payload);

  factory ViewSymptomsScreen.fromBase64(String jwt) => ViewSymptomsScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  State<ViewSymptomsScreen> createState() => _ViewSymptomsScreenState();
}

class _ViewSymptomsScreenState extends State<ViewSymptomsScreen> {
  final ApiClient _apiClient = ApiClient();
  final ApiDoctor _apiDoctor = ApiDoctor();

  List<PatientModel> _patients = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    List<PatientModel> patients =
        await _apiClient.fetchUsers(); // load the availabilities on Widget init

    setState(() => _patients = patients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context, widget.jwt),
      body: ListView.separated(
        itemCount: _patients.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text('Check detail'),
                        content: Text(
                            'Patient: ${_patients[i].firstName} ${_patients[i].lastName}\nID: ${_patients[i].id}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              PatientSymptomsModel symptoms =
                                  await _apiClient.getSymptoms(
                                      _patients[i].username.toString());
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: const Text('Details'),
                                        content: Text(
                                            'Pain Scale: ${symptoms.painScale}\nBody Temperature: ${symptoms.bodyTemperature}\nCough: ${symptoms.cough}\nRunny Nose: ${symptoms.runnyNose}\n'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewSymptomsScreen
                                                              .fromBase64(
                                                                  widget.jwt)));
                                            },
                                            child: const Text('ok'),
                                          ),
                                        ]);
                                  });
                            },
                            child: const Text('Click to view symptoms'),
                          ),
                        ]);
                  });
            },
            child: Column(
              children: [
                Text(
                  "Patient: ${_patients[i].firstName} ${_patients[i].lastName}\nID: ${_patients[i].id}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
