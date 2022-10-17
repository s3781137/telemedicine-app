import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/screens/admin.dart';
import '../model/doctor_model.dart';
import '../widgets/appBar.dart';

class DeleteDoctorScreen extends StatefulWidget {
  const DeleteDoctorScreen(this.jwt, this.payload);

  factory DeleteDoctorScreen.fromBase64(String jwt) => DeleteDoctorScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  State<DeleteDoctorScreen> createState() => _DeleteDoctorScreenState();
}

class _DeleteDoctorScreenState extends State<DeleteDoctorScreen> {
  final ApiAdmin _apiAdmin = ApiAdmin();
  List<DoctorModel> _doctors = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    List<DoctorModel> doctors = await _apiAdmin
        .fetchDoctors(); // load the availabilities on Widget init

    setState(() => _doctors = doctors);
  }

  void deleteDoctor(int i) async {
    dynamic res = await _apiAdmin.deleteDoctor(_doctors[i].username);
    if (res == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Delete Success'),
                content: const Text('Doctor has been deleted'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Admin.fromBase64(widget.jwt)));
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
                content: const Text('Cannot delete doctor'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
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
        itemCount: _doctors.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            onTap: () {
              deleteDoctor(i);
            },
            child: Column(
              children: [
                Text(
                    "Doctor: ${_doctors[i].firstName} ${_doctors[i].lastName}"),
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
