import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/screens/doctor_profile.dart';
import 'package:flutter_application/doctor/core/api_doctor.dart';
import 'package:flutter_application/doctor/screens/add_medication.dart';
import 'package:flutter_application/doctor/screens/doctor.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/core/api_patient.dart';
import 'package:flutter_application/patient/model/patient_medicine_model.dart';
import 'package:flutter_application/patient/model/patient_model.dart';
import 'package:flutter_application/patient/model/petient_health_model.dart';
import '../model/doctor_model.dart';
import '../widget/appBar.dart';

class PatientMedicScreen extends StatefulWidget {
  const PatientMedicScreen(this.jwt, this.payload, this.username);

  factory PatientMedicScreen.fromBase64(String jwt, String username) =>
      PatientMedicScreen(
          jwt,
          json.decode(
              ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))),
          username);

  final String jwt;
  final String username;
  final Map<String, dynamic> payload;

  @override
  State<PatientMedicScreen> createState() => _PatientMedicScreenState();
}

class _PatientMedicScreenState extends State<PatientMedicScreen> {
  final ApiDoctor _apiDoctor = ApiDoctor();

  List<PatientMedicineModel> _prescription = [];

  // load initial data from database
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    List<PatientMedicineModel> prescription = await _apiDoctor.getMedications(
        widget.username); // load the prescription on Widget init

    setState(() => _prescription = prescription);
  }

  // function for deleting medicine
  void deleteMedicine(int i) async {
    dynamic res = await _apiDoctor.deleteMeidicine(_prescription[i]);
    if (res == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Delete Success'),
                content: const Text('Medicine has been deleted'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Doctor.fromBase64(widget.jwt)));
                    },
                    child: const Text('OK'),
                  ),
                ]);
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Delete Failure'),
                content: const Text('Cannot delete medicine'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Doctor.fromBase64(widget.jwt)));
                    },
                    child: const Text('OK'),
                  ),
                ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context, widget.jwt),
      body: ListView.separated(
        itemCount: _prescription.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text('Check detail'),
                        content: Text(
                            'ID: ${_prescription[i].id}\n Precriptions: ${_prescription[i].medicine}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AddMedication.fromBase64(
                                          widget.jwt, widget.username)));
                            },
                            child: const Text('Add medication'),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteMedicine(i);
                            },
                            child: const Text('Delete medication'),
                          ),
                        ]);
                  });
            },
            child: Column(
              children: [
                Text(
                  "Medicine: ${_prescription[i].medicine}",
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
