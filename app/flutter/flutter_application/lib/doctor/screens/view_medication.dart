import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/screens/doctor_profile.dart';
import 'package:flutter_application/doctor/core/api_doctor.dart';
import 'package:flutter_application/doctor/screens/patient_medication.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/core/api_patient.dart';
import 'package:flutter_application/patient/model/patient_medicine_model.dart';
import 'package:flutter_application/patient/model/patient_model.dart';
import 'package:flutter_application/patient/model/petient_health_model.dart';
import '../model/doctor_model.dart';
import '../widget/appBar.dart';

class ViewMedicationScreen extends StatefulWidget {
  const ViewMedicationScreen(this.jwt, this.payload);

  factory ViewMedicationScreen.fromBase64(String jwt) => ViewMedicationScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  State<ViewMedicationScreen> createState() => _ViewMedicationScreenState();
}

class _ViewMedicationScreenState extends State<ViewMedicationScreen> {
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
        await _apiClient.fetchUsers(); // load the patients on Widget init

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PatientMedicScreen.fromBase64(
                      widget.jwt, _patients[i].username.toString())));
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
