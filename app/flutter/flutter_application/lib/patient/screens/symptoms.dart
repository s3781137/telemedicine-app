import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/patient/model/patient_model.dart';
import 'package:flutter_application/patient/model/patient_profile_model.dart';

import '../../main.dart';
import '../core/api_patient.dart';
import '../model/patient_symptoms_model.dart';
import '../patient.dart';
import '../widgets/appbar.dart';

class Symptoms extends StatefulWidget {
  const Symptoms({required this.symptoms});
  final PatientSymptomsModel symptoms;
  @override
  State<Symptoms> createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  final TextEditingController _painScaleController = TextEditingController();
  final TextEditingController _bodyTemperatureController =
      TextEditingController();
  final TextEditingController _coughController = TextEditingController();
  final TextEditingController _runnyNoseController = TextEditingController();
  bool _validate = false;
  final ApiClient _apiClient = ApiClient();
  Future<void> updateSymptoms(dynamic username) async {
    PatientSymptomsModel symptoms = PatientSymptomsModel(
        painScale: int.parse(_painScaleController.text),
        bodyTemperature: double.parse(_bodyTemperatureController.text),
        cough: _coughController.text,
        runnyNose: _runnyNoseController.text == 'true',
        userName: username);
    if (_validate == false) {
      dynamic res = await _apiClient.updateSymptoms(username, symptoms);
      if (res == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Update Success'),
                  content: const Text('Your Symptoms has been updated'),
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
    _painScaleController.dispose();
    _bodyTemperatureController.dispose();
    _coughController.dispose();
    _runnyNoseController.dispose();
    super.dispose();
  }

  void _fetchUserData() async {
    setState(() {
      _painScaleController.text = widget.symptoms.painScale.toString();
      _bodyTemperatureController.text =
          widget.symptoms.bodyTemperature.toString();
      _coughController.text = widget.symptoms.cough.toString();
      _runnyNoseController.text = widget.symptoms.runnyNose.toString();
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
                      'Manage Symptoms',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _painScaleController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'PainScale (Integer only)',
                      errorText: _validate
                          ? 'PainScale Can only be integer and not empty'
                          : null,
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
                    controller: _bodyTemperatureController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Body Temperature',
                      errorText:
                          _validate ? 'Temperature Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: _coughController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Cough',
                      errorText: _validate ? 'Cough Can\'t Be Empty' : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _runnyNoseController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Runny Nose ("true" or "false")',
                      errorText: _validate
                          ? 'Runny Nose Can Only be "true" or "false"'
                          : null,
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
                          if (_painScaleController.text.isEmpty |
                              _bodyTemperatureController.text.isEmpty |
                              _coughController.text.isEmpty |
                              _runnyNoseController.text.isEmpty |
                              (_runnyNoseController.text != "false" &&
                                  _runnyNoseController.text != "true")) {
                            _validate = true;
                          } else {
                            _validate = false;
                          }
                        });
                        updateSymptoms(currentLoggedInUser["username"]);
                      },
                    )),
              ],
            )));
  }
}
