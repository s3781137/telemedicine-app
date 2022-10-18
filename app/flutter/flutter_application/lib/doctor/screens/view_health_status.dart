import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/screens/doctor_profile.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/core/api_patient.dart';
import 'package:flutter_application/patient/model/patient_model.dart';
import '../model/doctor_model.dart';
import '../widget/appBar.dart';

class ViewHealthStatusScreen extends StatefulWidget {
  const ViewHealthStatusScreen(this.jwt, this.payload);

  factory ViewHealthStatusScreen.fromBase64(String jwt) =>
      ViewHealthStatusScreen(
          jwt,
          json.decode(ascii
              .decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  State<ViewHealthStatusScreen> createState() => _ViewHealthStatusScreenState();
}

class _ViewHealthStatusScreenState extends State<ViewHealthStatusScreen> {
  final ApiClient _apiClient = ApiClient();
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
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) =>
              //         .fromBase64(widget.jwt, _patients[i])));
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text('Check detail'),
                        content: Text(
                            'Patient: ${_patients[i].firstName} ${_patients[i].lastName}\nUsername: ${_patients[i].username}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {},
                            child: const Text('Click to view health status'),
                          ),
                        ]);
                  });
            },
            child: Column(
              children: [
                Text(
                  "Patient: ${_patients[i].firstName} ${_patients[i].lastName}",
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
