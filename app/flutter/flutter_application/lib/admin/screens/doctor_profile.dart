import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';

import '../model/doctor_model.dart';
import '../widgets/appBar.dart';
import 'admin.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile(this.jwt, this.payload, this.doctor);

  factory DoctorProfile.fromBase64(
          String jwt, DoctorModel doctor) =>
      DoctorProfile(
          jwt,
          json.decode(
              ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))),
          doctor);

  final String jwt;
  final DoctorModel doctor;
  final Map<String, dynamic> payload;
  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _validate = false;
  final ApiAdmin _apiAdmin = ApiAdmin();

  Future<void> updateProfile(int? id) async {
    DoctorModel doctorNew = DoctorModel(
      id: id,
      username: usernameController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
    );
    if (_validate == false) {
      dynamic res = await _apiAdmin.updateDoctor(doctorNew);
      if (res == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Update Success'),
                  content: const Text('Doctor Profile has been updated'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Admin.fromBase64(widget.jwt)));
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
                  title: const Text('Update Failure'),
                  content: const Text('Cannot update profile'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
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
    _fetchUserData();
  }

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _fetchUserData() async {
    // do something
    setState(() {
      usernameController.text = widget.doctor.username!;
      firstNameController.text = widget.doctor.firstName!;
      lastNameController.text = widget.doctor.lastName!;
      emailController.text = widget.doctor.email!;
    });
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
                      'Manage Doctor',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Username',
                      errorText: _validate ? 'Username Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'First Name',
                      errorText:
                          _validate ? 'First Name Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Last Name',
                      errorText: _validate ? 'Last Name Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      errorText: _validate ? 'Email Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Update'),
                      onPressed: () {
                        setState(() {
                          if (usernameController.text.isEmpty |
                              firstNameController.text.isEmpty |
                              lastNameController.text.isEmpty |
                              emailController.text.isEmpty) {
                            _validate = true;
                          } else {
                            _validate = false;
                          }
                        });
                        updateProfile(widget.doctor.id);
                      },
                    )),
              ],
            )));
  }
}
