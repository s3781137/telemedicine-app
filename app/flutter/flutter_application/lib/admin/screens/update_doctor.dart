import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/screens/doctor_profile.dart';
import 'package:flutter_application/main.dart';
import '../model/doctor_model.dart';
import '../widgets/appBar.dart';

class UpdateDoctorScreen extends StatefulWidget {
  const UpdateDoctorScreen(this.jwt, this.payload);

  factory UpdateDoctorScreen.fromBase64(String jwt) => UpdateDoctorScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  State<UpdateDoctorScreen> createState() => _UpdateDoctorScreenState();
}

class _UpdateDoctorScreenState extends State<UpdateDoctorScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context, widget.jwt),
      body: ListView.separated(
        itemCount: _doctors.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DoctorProfile.fromBase64(widget.jwt, _doctors[i])));
            },
            child: Column(
              children: [
                Text(
                  "Doctor: ${_doctors[i].firstName} ${_doctors[i].lastName}",
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
