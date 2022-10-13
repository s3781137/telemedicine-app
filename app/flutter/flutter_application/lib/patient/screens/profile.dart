import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/patient/model/patient_model.dart';
import 'package:flutter_application/patient/model/patient_profile_model.dart';

import '../../main.dart';
import '../core/api_patient.dart';
import '../patient.dart';
import '../widgets/appbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  int? id = -1;
  Future<void> updateProfile(dynamic username) async {
    id = await _apiClient.getUserId(username);
    PatientProfileModel profile = PatientProfileModel(
        id: id,
        gender: genderController.text,
        weight: double.parse(weightController.text),
        height: double.parse(heightController.text),
        contactNo: contactNoController.text,
        contactName: contactNameController.text);
    dynamic res = await _apiClient.updateProfile(profile);
    // todo debug msg
    print(res);
    // todo: condition check fix
    // currently the returned res is like:
    // {"id":58,"username":"runhuizhou","password":"blahblah","confirmPassword":"blahblah","firstName":"runhui","lastName":"zhou","status":null,"email":"123141@gg.com","gender":"test","weight":100.0,"height":10000.0,"contactNo":"110","contactName":"family"}
    // I don't know how to check
    if (res.toString().contains("id")) {
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

  Future<void> checkProfile(dynamic username) async {
    id = await _apiClient.getUserId(username);
    PatientModel patient = await _apiClient.getUser(username);
    // todo condition check
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Current profile'),
              content: Text(
                  "Gender: ${patient.gender}\nWeight: ${patient.weight}\nHeight: ${patient.height}\nContact Number: ${patient.contactNo}\nContact Name: ${patient.contactName}"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Patient())),
                  child: const Text('OK'),
                ),
              ]);
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
                    controller: genderController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Gender',
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
                    controller: weightController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Weight',
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
                    controller: heightController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Height',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: contactNoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: contactNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Name',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Update'),
                      onPressed: () {
                        updateProfile(currentLoggedInUser["username"]);
                        // todo debug message
                        print(genderController.text);
                        print(weightController.text);
                        print(heightController.text);
                        print(contactNoController.text);
                        print(contactNameController.text);
                      },
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Check current profile'),
                      onPressed: () {
                        checkProfile(currentLoggedInUser["username"]);
                      },
                    )),
              ],
            )));
  }
}
