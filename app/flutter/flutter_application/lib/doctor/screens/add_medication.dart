import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/model/admin_model.dart';
import 'package:flutter_application/admin/screens/login.dart';
import 'package:flutter_application/admin/widgets/appBar.dart';
import 'package:flutter_application/doctor/core/api_doctor.dart';
import 'package:flutter_application/doctor/screens/doctor.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/core/api_patient.dart';
import 'package:flutter_application/patient/model/patient_medicine_model.dart';

class AddMedication extends StatefulWidget {
  const AddMedication(this.jwt, this.payload, this.username);

  factory AddMedication.fromBase64(String jwt, String username) =>
      AddMedication(
          jwt,
          json.decode(
              ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))),
          username);

  final String jwt;
  final String username;
  final Map<String, dynamic> payload;

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  final TextEditingController _medicineController = TextEditingController();
  final ApiDoctor _apiDoctor = ApiDoctor();
  bool _validate = false;

  void addMedication() async {
    PatientMedicineModel medicine = PatientMedicineModel(
        doctorUsername: currentLoggedInUser["username"].toString(),
        patientUsername: widget.username,
        medicine: _medicineController.text);
    if (_validate == false) {
      dynamic res = await _apiDoctor.addMedication(medicine);
      if (res == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Add Success'),
                  content: const Text('Medication has been added to patient'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Doctor.fromBase64(widget.jwt)));
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
                  title: const Text('Add Failure'),
                  content: const Text('Cannot add medicine'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Doctor.fromBase64(widget.jwt)));
                      },
                      child: const Text('OK'),
                    ),
                  ]);
            });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _medicineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar(context, widget.jwt),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Add Medication',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _medicineController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Medication',
                      errorText:
                          _validate ? 'Medication Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () {
                        setState(() {
                          if (_medicineController.text.isEmpty) {
                            _validate = true;
                          } else {
                            _validate = false;
                          }
                        });
                        addMedication();
                      },
                    )),
              ],
            )));
  }
}
