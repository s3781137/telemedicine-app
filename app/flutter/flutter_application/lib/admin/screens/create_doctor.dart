import 'package:flutter/material.dart';
import 'package:flutter_application/admin/api/api_admin.dart';
import 'package:flutter_application/admin/screens/admin.dart';
import 'package:flutter_application/admin/screens/login.dart';

import '../model/doctor_model.dart';

class CreateDoctor extends StatefulWidget {
  const CreateDoctor({Key? key}) : super(key: key);

  @override
  State<CreateDoctor> createState() => _CreateDoctorState();
}

class _CreateDoctorState extends State<CreateDoctor> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final ApiAdmin _apiAdmin = ApiAdmin();

  Future<void> createDoctor() async {
    DoctorModel doctor = DoctorModel(
        username: usernameController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text);
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
                    // onPressed: () => Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Admin.fromBase64(jwt))),
                    // todo: need fix routing because of jwt implementation
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/adminsignin'),
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
        appBar: AppBar(
          title: const Text('ND TELEMEDICINE'),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   // todo fix routing
                    //     MaterialPageRoute(builder: (context) => Patient()));
                  },
                  child: const Icon(Icons.home),
                )),
          ],
        ),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () {
                        createDoctor();
                      },
                    )),
              ],
            )));
  }
}
