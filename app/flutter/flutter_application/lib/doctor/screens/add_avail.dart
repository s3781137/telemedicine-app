import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/doctor/core/api_doctor.dart';
import 'package:flutter_application/doctor/screens/doctor.dart';
import 'package:flutter_application/main.dart';

import '../widget/appBar.dart';

class AddAvail extends StatefulWidget {
  const AddAvail(this.jwt, this.payload);

  factory AddAvail.fromBase64(String jwt) => AddAvail(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;
  @override
  State<AddAvail> createState() => _AddAvailState();
}

class _AddAvailState extends State<AddAvail> {
  final TextEditingController _availController = TextEditingController();
  bool _validate = false;
  final ApiDoctor _apiDoctor = ApiDoctor();
  Future<void> addAvail() async {
    if (_validate == false) {
      dynamic res = await _apiDoctor.addAvail(
          currentLoggedInUser["username"].toString(), _availController.text);
      if (res == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Add Availability Success'),
                  content: const Text('Availability added'),
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
                  title: const Text('Add Availability Failure'),
                  content: const Text('Cannot add availability'),
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
    _availController.dispose();
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
                    controller: _availController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Availibility (Date and Time)',
                      errorText:
                          _validate ? 'Availability Can\'t Be Empty' : null,
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
                          if (_availController.text.isEmpty) {
                            _validate = true;
                          } else {
                            _validate = false;
                          }
                        });
                        addAvail();
                      },
                    )),
              ],
            )));
  }
}
