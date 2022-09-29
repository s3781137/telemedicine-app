import 'package:flutter/material.dart';

const List<String> testPatients = <String>["Hellen", "Dave", "John", "Rose"];

class doctorChat extends StatelessWidget {
  const doctorChat();

  @override
  Widget build(BuildContext context) {
    return doctorChatContent();
  }
}

class doctorChatContent extends StatefulWidget {
  const doctorChatContent();

  @override
  _doctorChatContentState createState() => _doctorChatContentState();
}

class _doctorChatContentState extends State<doctorChatContent> {
  //For testing

  String _dropdownValue = testPatients.first;

  //Gets a list of the patients
  List<DropdownMenuItem<String>> retrievePatients() {
    //This is dummy code that needs to be implemented with db items

    /*
    List<DropdownMenuItem<String>> returnVal = [];
    for (String patients in testPatients) {
      var newItem = DropdownMenuItem<String>(
        value: patients,
        child: Text(patients),
      );
      returnVal.add(newItem);
    }
    */

    return testPatients.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            value,
          ),
        ),
      );
    }).toList();
  }

  void onDropdownChange(String? value) {
    setState(() {
      _dropdownValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ND TELEMEDICINE'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Select a patient:",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    //Makes the dropdown bigger
                    width: 200,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: retrievePatients(),
                      value: _dropdownValue,
                      onChanged: onDropdownChange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
