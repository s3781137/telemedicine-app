import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/patient/model/patient_model.dart';
import 'package:flutter_application/patient/model/patient_profile_model.dart';

import '../../main.dart';
import '../core/api_patient.dart';
import '../patient.dart';
import '../widgets/appbar.dart';

class Profile extends StatefulWidget {
  const Profile({required this.patient});
  final PatientModel patient;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // textcontrollers for inputs
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  bool _validate = false;
  final ApiClient _apiClient = ApiClient();
  int? id = -1;
  Future<void> updateProfile(dynamic username) async {
    id = await _apiClient.getUserId(username);
    PatientProfileModel profile = PatientProfileModel(
        id: id,
        gender: _genderController.text,
        weight: double.parse(_weightController.text),
        height: double.parse(_heightController.text),
        contactNo: _contactNoController.text,
        contactName: _contactNameController.text);
    // check if all text fields are not empty
    if (_validate == false) {
      dynamic res = await _apiClient.updateProfile(profile);
      if (res == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Update Success'),
                  content: const Text('Your Profile has been updated'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Patient())),
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
    _genderController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _contactNoController.dispose();
    _contactNameController.dispose();
    super.dispose();
  }

  void _fetchUserData() async {
    setState(() {
      _genderController.text = widget.patient.gender!;
      _weightController.text = widget.patient.weight!.toString();
      _heightController.text = widget.patient.height!.toString();
      _contactNoController.text = widget.patient.contactNo!;
      _contactNameController.text = widget.patient.contactName!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar(context),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Manage Profile',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Gender',
                      errorText: _validate ? 'Gender Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                    controller: _weightController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Weight',
                      errorText: _validate ? 'Weight Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                    controller: _heightController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Height',
                      errorText: _validate ? 'Height Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _contactNoController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Contact Number',
                      errorText:
                          _validate ? 'Contact Number Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _contactNameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Contact Name',
                      errorText:
                          _validate ? 'Concat Name Can\'t Be Empty' : null,
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
                          if (_genderController.text.isEmpty |
                              _heightController.text.isEmpty |
                              _weightController.text.isEmpty |
                              _contactNoController.text.isEmpty |
                              _contactNameController.text.isEmpty) {
                            _validate = true;
                          } else {
                            _validate = false;
                          }
                        });
                        updateProfile(currentLoggedInUser["username"]);
                      },
                    )),
              ],
            )));
  }
}
