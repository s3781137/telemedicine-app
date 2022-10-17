import 'dart:convert';

import 'package:conditional_questions/conditional_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/screens/admin.dart';
import 'package:flutter_application/admin/screens/login.dart';

import '../model/doctor_model.dart';
import '../widgets/appBar.dart';

class CreateDoctor extends StatefulWidget {
  const CreateDoctor(this.jwt, this.payload);

  factory CreateDoctor.fromBase64(String jwt) => CreateDoctor(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;
  @override
  State<CreateDoctor> createState() => _CreateDoctorState();
}

class _CreateDoctorState extends State<CreateDoctor> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _validate = false;
  final ApiAdmin _apiAdmin = ApiAdmin();

  Future<void> createDoctor() async {
    DoctorModel doctor = DoctorModel(
        username: usernameController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text);
    if (_validate == false) {
      dynamic res = await _apiAdmin.createDoctor(doctor);
      if (res == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Create Success'),
                  content: const Text('Doctor has been created'),
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
                  title: const Text('Create Failure'),
                  content: const Text('Cannot create doctor'),
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
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
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
                      'Create Doctor',
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      errorText: _validate ? 'Passsword Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      child: const Text('Register'),
                      onPressed: () {
                        setState(() {
                          if (usernameController.text.isEmpty |
                              passwordController.text.isEmpty |
                              firstNameController.text.isEmpty |
                              lastNameController.text.isEmpty |
                              emailController.text.isEmpty) {
                            _validate = true;
                          } else {
                            _validate = false;
                          }
                        });
                        createDoctor();
                      },
                    )),
              ],
            )));
  }
}
